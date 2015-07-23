FROM fedora:rawhide
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y install openvswitch && dnf clean all; \
systemctl enable openvswitch.service

RUN systemctl mask systemd-remount-fs.service dev-hugepages.mount \
    sys-fs-fuse-connections.mount systemd-logind.service getty.target \
    console-getty.service dnf-makecache.service
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/; \
    sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service

VOLUME ["/run", "/tmp"]

ENV container=docker

CMD ["/usr/sbin/init"]
