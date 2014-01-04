FROM fedora
MAINTAINER "Scott Collier" <scollier@redhat.com>

RUN yum -y update
RUN yum -y install httpd
RUN echo "Apache" >> /var/www/html/index.html

EXPOSE 80

CMD /usr/sbin/apachectl -D FOREGROUND
