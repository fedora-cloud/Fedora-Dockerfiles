#!/bin/sh

# If /var/log or /run are mounted as volumes, they may initially be
# empty. We need to ensure that the following directories exist.

# This is the target of the "default" storage pool.
mkdir -p /var/log/libvirt/images

# This is used by "virsh console" to create lock files.  Technically,
# "virsh console" uses /var/lock, but that is a symlink to /run/lock.
mkdir -p /run/lock

# Make sure permissions on /dev/kvm are correct.
if [ -c /dev/kvm ]; then
	chown qemu:qemu /dev/kvm
else
	echo "*** no /dev/kvm"
fi

exec "$@"
