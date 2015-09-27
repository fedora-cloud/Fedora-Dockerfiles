#!/bin/bash

set -e
# set -x

mkdir -p /var/log/sssd
export _SYSTEMCTL_LITE_LOGFILE=/var/log/sssd/systemctl.log
touch $_SYSTEMCTL_LITE_LOGFILE
tail -f $_SYSTEMCTL_LITE_LOGFILE &

perl -F: -lane 'next if $X{$F[0]}++; print;' /etc/passwd /etc/passwd.host > /etc/passwd.new && cp /etc/passwd.new /etc/passwd

function stop_running () {
	systemctl stop-running
	exit
}
trap exit TERM
trap stop_running EXIT

exec &>> /var/log/sssd-run.log

systemctl start sssd.service

while true ; do sleep 1000 & wait $! ; done

