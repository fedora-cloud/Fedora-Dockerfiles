#!/bin/sh

mkdir -p /data

if [ ! -f /data/dhcpd.conf ]; then
    ipaddr=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}')
    eval $(/bin/ipcalc --network ${ipaddr})
    eval $(/bin/ipcalc --netmask ${ipaddr})
    cp /default_dhcpd.conf /data/dhcpd.conf
    echo "subnet $NETWORK netmask $NETMASK { }" >> /data/dhcpd.conf
fi

if [ ! -f /data/dhcpd.leases ]; then
    touch /data/dhcpd.leases
fi

exec /usr/sbin/dhcpd $@
