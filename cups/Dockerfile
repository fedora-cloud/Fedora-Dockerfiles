FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum -y install cups openssl passwd && yum clean all
ADD adjust-config.sh /adjust-config.sh
ADD start-cups.sh /start-cups.sh
RUN chmod 755 /adjust-config.sh /start-cups.sh
RUN /adjust-config.sh

VOLUME ["/var/spool/cups", "/var/log/cups"]
EXPOSE 631

CMD ["/start-cups.sh"]
