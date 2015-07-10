#!/bin/bash

if [[ "${1}" = "dhcp4" ]]; then

  if [[ ! -f /var/lib/kea/kea-leases4.csv ]]; then
        touch /var/lib/kea/kea-leases4.csv
  fi

  exec kea-dhcp4 -d -c /etc/kea/kea.conf

elif [[ "${1}" = "dhcp6" ]]; then

  if [[ ! -f /var/lib/kea/kea-leases6.csv ]]; then
        touch /var/lib/kea/kea-leases6.csv
  fi

  exec kea-dhcp6 -d -c /etc/kea/kea.conf

elif [[ "${1}" = "ddns" ]]; then

  exec kea-dhcp-ddns -d -c /etc/kea/kea.conf

else

    exec "$@"

fi


