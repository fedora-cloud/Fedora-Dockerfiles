# Based on the Fedora image
FROM fedora

MAINTAINER "Maciej Lasyk" <maciek@lasyk.info>

# install main packages:
RUN yum -y update
RUN yum -y install bind-utils bind cronie logrotate supervisor

# gen rndc key:
RUN rndc-confgen -a -c /etc/rndc.key
RUN chown named:named /etc/rndc.key

# copy cfg files:
ADD ./cfg_files/rsyslogd.d/20-bind.conf /etc/rsyslogd.d/20-bind.conf
ADD ./cfg_files/logrotate.d/named /etc/logrotate.d/named
ADD ./cfg_files/init.d/named /etc/init.d/named
ADD ./cfg_files/named.conf /etc/named.conf
ADD ./cfg_files/cron.daily/update_named.ca.sh /etc/cron.daily/update_named.ca.sh
ADD ./cfg_files/supervisord.conf /etc/supervisord.conf
ADD ./cfg_files/supervisord.d/cron.ini /etc/supervisord.d/cron.ini
ADD ./cfg_files/supervisord.d/named.ini /etc/supervisord.d/named.ini

# set up the env:
RUN chmod +x /etc/init.d/named
RUN mkdir /var/dockerlock/subsys -p
RUN mkdir /var/log/named
RUN chown named:named /var/log/named
RUN mkdir -p /var/log/supervisor

EXPOSE 53

# start services:
CMD ["/usr/bin/supervisord"]
