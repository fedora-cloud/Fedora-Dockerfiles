FROM fedora:22
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install nginx && dnf clean all

ADD nginx.conf.dist /etc/nginx/nginx.conf
RUN mkdir -p /srv/www/logs /srv/www/sites/enabled

VOLUME [ "/srv/www/logs/", "/srv/www/sites/enabled" ]
EXPOSE 80

CMD [ "/usr/sbin/nginx" ]
