FROM fedora/systemd-systemd
MAINTAINER http://fedoraproject.org/wiki/Cloud

# USING THIS CONTAINER
#
# # docker run --privileged -d \
# 	--net=host \
#	--device /dev/kvm:/dev/kvm \
# 	-v /var/lib/libvirt:/var/lib/libvirt:rw \
# 	-v /var/run/libvirt:/var/run/libvirt:rw \
# 	-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
# 	fedora/systemd-libvirtd

VOLUME /var/lib/libvirt
VOLUME /var/log
VOLUME /run

# The default configuration for this image permits unauthenticated tcp
# connections to libvirt on this port.  Do not publish this port without
# providing an alternative configuration.
EXPOSE 16509

RUN dnf -y install \
	libvirt \
	qemu \
	qemu-kvm \
	virt-install \
	pygobject3-base \
	&& dnf clean all

# Enable libvirtd and virtlockd services.
RUN systemctl enable libvirtd
RUN systemctl enable virtlockd

# Add configuration for "default" storage pool.
RUN mkdir -p /etc/libvirt/storage
COPY pool-default.xml /etc/libvirt/storage/default.xml

# Install the libvirtd configuration file.
COPY libvirtd.conf /etc/libvirt/libvirtd.conf

# This is necessary to make libvirtd listen on the port defined
# in the configuration file.
RUN echo 'LIBVIRTD_ARGS="--listen"' >> /etc/sysconfig/libvirtd

# The entrypoint.sh script runs before services start up to ensure that
# critical directories and permissions are correct.
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/sbin/init"]

