#!/bin/sh

. /usr/share/cont-postgresql/atomic/include.sh

# Create directories on host from spc
mkdir -p "${HOST}/${data_dir}"
chcon -Rt svirt_sandbox_file_t "${HOST}/${data_dir}"
chown -R postgres:postgres "${HOST}/${data_dir}"
chmod -R 700 "${HOST}/${data_dir}"

# create container on host
chroot "${HOST}" /usr/bin/docker create -v "${data_dir}:/var/lib/pgsql/data:Z" \
    --name "${NAME}" ${OPT2} "${IMAGE}" ${OPT3}

# Create and enable systemd unit file for the service
sed -e "s/TEMPLATE/${NAME}/g" "/usr/share/cont-postgresql/atomic/"template.service > "${HOST}/etc/systemd/system/${service_name}.service"
chroot "${HOST}" /usr/bin/systemctl enable "/etc/systemd/system/${service_name}.service"
