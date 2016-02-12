FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud
ENV container docker
RUN dnf -y update && dnf clean all
RUN dnf -y install libvirt-daemon-driver* qemu systemd libvirt-daemon && dnf clean all && \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*; \
systemctl enable libvirtd; \
systemctl enable virtlockd 

EXPOSE 16509

# RUN echo "listen_tls = 0" >> /etc/libvirt/libvirtd.conf; \
# echo 'listen_tcp = 1' >> /etc/libvirt/libvirtd.conf; \
# echo 'tls_port = "16514"' >> /etc/libvirt/libvirtd.conf; \ 
# echo 'tcp_port = "16509"' >> /etc/libvirt/libvirtd.conf; \
# echo 'auth_tcp = "none"' >> /etc/libvirt/libvirtd.conf

ADD ./libvirtd.conf /etc/libvirt/libvirtd.conf

RUN echo 'LIBVIRTD_ARGS="--listen"' >> /etc/sysconfig/libvirtd

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
