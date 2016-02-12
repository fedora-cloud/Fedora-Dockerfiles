# Based on the Fedora image
FROM fedora

MAINTAINER http://fedoraproject.org/wiki/Cloud

# install main packages:
RUN dnf -y update && dnf clean all
RUN dnf -y install openssh-server rsyslog sudo pwgen lighttpd && dnf clean all

# copy cfg files:
ADD ./cfg_files/logrotate.d/sshd /etc/logrotate.d/sshd
ADD ./cfg_files/logrotate.d/lighttpd /etc/logrotate.d/lighttpd
ADD ./cfg_files/sudoers.d/lighttpd /etc/sudoers.d/lighttpd

# setup systemd to run
RUN systemctl mask systemd-remount-fs.service \
    dev-hugepages.mount sys-fs-fuse-connections.mount \
    systemd-logind.service getty.target console-getty.service

# set up env:
RUN mkdir /root/scripts -p
ADD ./cfg_files/root/scripts/init.sh /root/scripts/init.sh
RUN chmod +x /root/scripts/init.sh

# set up the sshd env:
ADD ./cfg_files/lighttpd/.ssh/authorized_keys /tmp/authorized_keys
RUN /root/scripts/init.sh

VOLUME ["/sys/fs/cgroup", "/run", "/tmp"]
ENV container=docker

RUN systemctl enable lighttpd.service
RUN systemctl enable sshd.service
RUN systemctl enable rsyslog.service

RUN systemctl mask systemd-remount-fs.service

EXPOSE 8091

# start services:
CMD ["/usr/sbin/init"]
