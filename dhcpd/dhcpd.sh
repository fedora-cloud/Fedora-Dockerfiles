#!/bin/sh

if [ ! -f /etc/dhcp/dhcpd.conf ]; then
    ipaddr=$(/usr/sbin/ip -o -4 addr list eth0 | awk '{print $4}')
    eval $(/usr/bin/ipcalc --network ${ipaddr})
    eval $(/usr/bin/ipcalc --netmask ${ipaddr})
    cat << EOF > /etc/dhcp/dhcpd.conf
#   see /usr/share/doc/dhcp/dhcpd.conf.example
#   see dhcpd.conf(5) man page

subnet ${NETWORK} netmask ${NETMASK} { }
EOF
fi

if [ ! -f /var/lib/dhcpd/dhcpd.leases ]; then
    touch /var/lib/dhcpd/dhcpd.leases
fi

exec /usr/sbin/dhcpd $@
