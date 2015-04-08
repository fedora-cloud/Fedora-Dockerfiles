FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud
RUN yum -y update && yum clean all
RUN yum -y install httpd php php-mysql php-gd pwgen psmisc tar && \
    yum clean all

ADD scripts /scripts
RUN curl -LO http://wordpress.org/latest.tar.gz                   && \
    tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1 && \
    rm /latest.tar.gz                                             && \
    chown -R apache:apache /var/www/                              && \
    chmod 755 /scripts/*

VOLUME ["/var/www/html/wp-content", "/var/log/httpd"]
EXPOSE 80

CMD ["/bin/bash", "/scripts/start.sh"]
