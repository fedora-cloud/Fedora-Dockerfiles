#!/bin/sh

. "/usr/share/cont-postgresql"/atomic/include.sh

chroot "${HOST}" /usr/bin/systemctl disable "${service_name}.service"
chroot "${HOST}" /usr/bin/systemctl stop "${service_name}.service"
rm -f "${HOST}/etc/systemd/system/${service_name}.service"

