FROM fedora

MAINTAINER "Mike DePaulo" <mikedep333@gmail.com>

ENV container docker

RUN yum -y update
# install main packages:
RUN yum -y install systemd openssh-server sudo pwgen x2goserver x2goserver-xsession
# Make the command-line significantly more usable
RUN yum -y install bash-completion man-db file net-tools
# Minimal set of fonts. Many (proprietary) apps do not run, or do not run correctly without them.
RUN yum -y install xorg-x11-fonts-Type1 xorg-x11-fonts-misc dejavu-lgc-sans-fonts xorg-x11-fonts-75dpi xorg-x11-fonts-100dpi 

# Discuss creating multiple Dockerfiles per each supported desktop enviornment
# (and a base one for seamless window mode) with Fedora devel.
# In the meantime, just install MATE.
#
# Note: This installs many things we need like systemd as well as things we do
# not need like the Linux kernel.
RUN yum -y groups install fedora-release-nonproduct fonts input-methods mate-desktop

RUN yum -y remove anaconda-core
RUN yum clean all

# Make the command-line significantly more usable
RUN mandb

RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
# With X2Go Client for Windows 4.0.3.2, for some reason, I had to create this
# type of key.
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa -b 256

# copy cfg files:
#ADD ./cfg_files/supervisord.conf /etc/supervisord.conf
#ADD ./cfg_files/logrotate.d/sshd /etc/logrotate.d/sshd
#ADD ./cfg_files/init.d/sshd /etc/init.d/sshd
#ADD ./cfg_files/supervisord.d/sshd.ini /etc/supervisord.d/sshd.ini
#ADD ./cfg_files/supervisord.d/rsyslog.ini /etc/supervisord.d/rsyslog.ini

# set up env:
#RUN chmod +x /etc/init.d/{sshd}
#RUN mkdir /root/scripts -p
#ADD ./cfg_files/root/scripts/init.sh /root/scripts/init.sh
#RUN chmod +x /root/scripts/init.sh

# set up the sshd env:
#ADD ./cfg_files/lighttpd/.ssh/authorized_keys /tmp/authorized_keys
#RUN /root/scripts/init.sh

# and the supervisor env:
#RUN mkdir -p /var/log/supervisor


# start.sh script from the fedora/ssh Dockerfile
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
RUN ./start.sh
RUN usermod -a -G wheel user

# Fix login. Otherwise, pam refuses to let you login via ssh with this message:
# System is booting up. See pam_nologin(8)
RUN sed --in-place=.orig 's/^account    required     pam_nologin.so/#account    required     pam_nologin.so/' /etc/pam.d/sshd

# References for systemd:
# https://github.com/fedora-cloud/Fedora-Dockerfiles/blob/master/systemd/apache/Dockerfile
#
# Except, anaconda.target.wants does not exist. anaconda.target does exist, and it has
# wants lines in it. So we removed anaconda above.
#
# X2Go does not depend on systemd. However, it is used for these reasons:
# 1. Enabling & configuring sshd without writing custom code to do so
# 2. Enabling x2gocleansessions without installing supervisor and then installing the upstream X2Go init script
# 3. Making systemd user services possible
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done);
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;
RUN rm -f /etc/systemd/system/*.wants/*;
RUN rm -f /lib/systemd/system/local-fs.target.wants/*;
RUN rm -f /lib/systemd/system/sockets.target.wants/*udev*;
RUN rm -f /lib/systemd/system/sockets.target.wants/*initctl*;
RUN rm -f /lib/systemd/system/basic.target.wants/*;
RUN systemctl enable sshd
RUN systemctl enable x2gocleansessions
VOLUME [ "/sys/fs/cgroup" ]
# start services:
CMD ["/usr/sbin/init"]
