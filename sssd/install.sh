#!/bin/bash

set -e
# set -x

HOST=${HOST:-/host}

REALM=false
if [ -n "$1" ] ; then
	if [ "$#" -eq "1" ] && [ "$1" == "--uninstall" ] ; then
		exec /bin/uninstall.sh
		exit 99
	fi
	if [ "$1" == 'realm' -o "$1" == "/sbin/realm" -o "$1" == "/usr/sbin/realm" ] ; then
		if [ "$#" -eq "2" ] && [ "$2" == "--help" -o "$2" == "help" ] ; then
			$1 $2
			exit $?
		fi
		COMMAND="$1 $2"
		shift ; shift
		params=("--install=/")
		REALM=true
	elif [ "${1#-}" == "$1" ] ; then
		COMMAND="$1"
		shift
	elif [ "$#" -eq "1" ] && [ "$1" == "--help" ] ; then
		ipa-client-install --help
		exit 0
	fi
fi

function setup_service () {
	if chroot $HOST systemctl -q is-active "$NAME" ; then
		chroot $HOST systemctl stop "$NAME"
	fi
	sed "s%\${IMAGE}%${IMAGE:-sssd}%g; s%\${NAME}%${NAME:-sssd}%g;" /etc/sssd.service.template > $HOST/etc/systemd/system/$NAME.service
	chroot $HOST systemctl daemon-reload
	echo "Service $NAME.service configured to run SSSD container."
}

if [ -e "$HOST/etc/ipa/default.conf" ] ; then
	echo 'IPA client is already configured on this system.' >&2
	if [ "$#" -eq "1" ] && [ "$1" == "--migrate" ] ; then
		setup_service
		exit 0
	fi
	echo 'Run atomic uninstall $IMAGE first.' >&2
	exit 1
fi

mkdir -p "$HOST/var/log/sssd/install/sssd"
mv /var/log /var/log-aside && ln -s "$HOST/var/log/sssd/install" /var/log

export _SYSTEMCTL_LITE_LOGFILE="$HOST/var/log/sssd/install/systemctl.log"
touch $_SYSTEMCTL_LITE_LOGFILE

params=()
function slurp_params () {
	if [ -f "$1" ] ; then
		readarray -t params < <( xargs -n 1 echo < "$1" )
	fi
}

echo "Initializing configuration context from host ..."
( cd "$HOST" && while read f ; do
	if [ -e "$f" ] ; then
		cp --parents -rp -t / "$f"
	fi
done ) < /etc/host-data-list
mkdir -p /etc/sssd/systemctl-lite-enabled
rm -rf /etc/systemctl-lite-enabled
ln -s /etc/sssd/systemctl-lite-enabled /etc/systemctl-lite-enabled

if [ -z "$COMMAND" ] ; then
	if [ -f "$HOST/etc/$NAME/realm-join-options" ] ; then
		COMMAND='realm join -v'
		slurp_params "$HOST/etc/$NAME/realm-join-options"
		REALM=true
	else
		COMMAND='ipa-client-install -U --no-ntp'
		slurp_params "$HOST/etc/$NAME/ipa-client-install-options"
	fi
fi

if $REALM ; then
	for f in "$HOST/etc/$NAME/realm-join-password" ; do
		if [ -f "$f" ] ; then
			PASSWORD_FILE="$f"
			break
		fi
	done
	systemctl start dbus.service
fi

params+=("$@")
if [ -n "$PASSWORD_FILE" ] ; then
	$COMMAND "${params[@]}" < "$PASSWORD_FILE"
else
	$COMMAND "${params[@]}"
fi

if $REALM ; then
	( echo ; echo includedir /var/lib/sss/pubconf/krb5.include.d/ ) >> /etc/krb5.conf
fi

echo "Copying new configuration to host ..."
while read f ; do
	if [ -e "$f" ] ; then
		cp --parents -rp -t "$HOST" "$f"
	fi
done < /etc/host-data-list
chroot "$HOST" restorecon -ri -f - < /etc/host-data-list

setup_service
