FROM fedora
MAINTAINER "Tim Waugh" <twaugh@redhat.com>

RUN yum -y update && yum clean all
RUN yum -y install cups openssl && yum clean all
ADD adjust-config.sh /adjust-config.sh
ADD start-cups.sh /start-cups.sh
RUN chmod 755 /adjust-config.sh /start-cups.sh
RUN /adjust-config.sh
RUN printf "ServerAlias localhost\n" >> /etc/cups/cupsd.conf

EXPOSE 631

CMD ["/start-cups.sh"]
