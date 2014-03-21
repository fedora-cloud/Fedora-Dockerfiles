FROM fedora
MAINTAINER "Scott Collier" <scollier@redhat.com>

RUN yum -y update
RUN yum -y install httpd
RUN echo "Apache" >> /var/www/html/index.html

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-apache.sh /run-apache.sh

CMD ["/run-apache.sh"]
