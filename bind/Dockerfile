# Based on the Fedora image
FROM fedora

MAINTAINER http://fedoraproject.org/wiki/Cloud

# install main packages:
RUN dnf -y update && dnf clean all
RUN dnf -y install bind-utils bind && dnf clean all

# gen rndc key:
RUN rndc-confgen -a -c /etc/rndc.key
RUN chown named:named /etc/rndc.key

# copy cfg files:
ADD ./cfg_files/named.conf /etc/named/named.conf
RUN mkdir /root/scripts -p
ADD ./cfg_files/root/scripts/init.sh /root/scripts/init.sh
RUN chmod +x /root/scripts/init.sh

# init env
RUN /root/scripts/init.sh

EXPOSE 53

# start services:
CMD /usr/sbin/named -u named -f
