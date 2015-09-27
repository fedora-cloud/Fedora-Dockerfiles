#!/bin/bash

set -e
# set -x

HOST=${HOST:-/host}
if [ -e "$HOST/etc/ipa/default.conf" ] ; then
	echo 'IPA client is already configured on this system.' >&2
	if [ "$#" -eq "1" ] && [ "$1" == "--migrate" ] ; then
		cp /etc/sssd.service.template $HOST/etc/systemd/system/$NAME.service
		chroot $HOST systemctl daemon-reload
		exit 0
	fi
	echo 'Run atomic uninstall sssd first.' >&2
	exit 1
fi

mkdir -p "$HOST/var/log/sssd/install/sssd"
mv /var/log /var/log-aside && ln -s "$HOST/var/log/sssd/install" /var/log

export _SYSTEMCTL_LITE_LOGFILE="$HOST/var/log/sssd/install/systemctl.log"
touch $_SYSTEMCTL_LITE_LOGFILE
tail -f "$HOST/var/log/sssd/install/systemctl.log" &

params=()
function slurp_params () {
	if [ -f "$1" ] ; then
		readarray -t params < <( xargs -n 1 echo < "$1" )
	fi
}

while read f ; do
	if [ -e "$HOST/$f" ] ; then
		f_dir=$( dirname "$f" )
		( cd "$HOST/$f_dir" && tar cf - $( basename "$f" ) ) | ( cd "$f_dir" && tar xvf - )
	fi
done < /etc/host-data-list
mkdir -p /etc/sssd/systemctl-lite-enabled
rm -rf /etc/systemctl-lite-enabled
ln -s /etc/sssd/systemctl-lite-enabled /etc/systemctl-lite-enabled

REALM=false
if [ -n "$1" ] ; then
	if [ "$1" == 'realm' -o "$1" == "/sbin/realm" -o "$1" == "/usr/sbin/realm" ] ; then
		COMMAND="$1 $2"
		shift ; shift
		params=("--install=/")
		REALM=true
	elif [ "${1#-}" == "$1" ] ; then
		COMMAND="$1"
		shift
	fi
fi

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

xargs -a /etc/host-data-list tar cf - | ( cd "$HOST" && tar xvf - )
xargs -a /etc/host-data-list chroot "$HOST" restorecon -rvi

cp /etc/sssd.service.template $HOST/etc/systemd/system/$NAME.service
chroot $HOST systemctl daemon-reload
