FROM fedora
MAINTAINER "Marcin Skarbek" <docker@skarbek.name>
ENV container docker
RUN yum -y update; yum clean all
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;
ADD sshd /etc/pam.d/sshd
RUN yum -y install openssh-server; yum clean all; \
systemctl enable sshd.service;
ADD start.sh /start.sh
RUN /bin/bash /start.sh
EXPOSE 22
VOLUME ["/sys/fs/cgroup"]
CMD ["/usr/sbin/init"]
