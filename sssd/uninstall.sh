#!/bin/bash

set -e
# set -x

HOST=${HOST:-/host}

mkdir -p "$HOST/var/log/sssd/uninstall"
mv /var/log /var/log-aside && ln -s "$HOST/var/log/sssd/uninstall" /var/log

export _SYSTEMCTL_LITE_LOGFILE="$HOST/var/log/sssd/uninstall/systemctl.log"
touch $_SYSTEMCTL_LITE_LOGFILE

echo "Initializing configuration context from host ..."
( cd "$HOST" && while read f ; do
	if [ -e "$f" ] ; then
		cp --parents -rp -t / "$f"
	fi
done ) < /etc/host-data-list

mkdir -p /etc/sssd/systemctl-lite-enabled
rm -rf /etc/systemctl-lite-enabled
ln -s /etc/sssd/systemctl-lite-enabled /etc/systemctl-lite-enabled

if [ -n "$1" ] ; then
	if [ "$1" == 'realm' -o "$1" == "/sbin/realm" -o "$1" == "/usr/sbin/realm" ] ; then
		COMMAND="$1 $2"
		shift ; shift
		params=("--install=/")
		systemctl start dbus.service
	elif [ "${1#-}" == "$1" ] ; then
		COMMAND="$1"
		shift
	fi
fi

if [ -z "$COMMAND" ] ; then
	if [ -f "$HOST/etc/$NAME/realm-join-options" ] ; then
		COMMAND='realm leave'
		params=("--install=/")
	else
		COMMAND='ipa-client-install -U --uninstall'
	fi
fi

$COMMAND "${params[@]}"

rm -rf /var/lib/sss/{mc,pipes}/*

echo "Copying new configuration to host ..."
while read f ; do
	( cd "$HOST" && find "$f" ) | while read g ; do
		if ! [ -e "/$g" ] ; then
			echo "Removing /$g"
			rm -rf "$HOST/$g"
		fi
	done
	if [ -e "$f" ] ; then
		cp --parents -rp -t "$HOST" "$f"
	fi
done < /etc/host-data-list

