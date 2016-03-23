FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud
RUN dnf -y update && dnf clean all

# Add our user and group first to make sure their IDs get assigned consistently
RUN groupadd -r mysql -g 1000 && \
    useradd -r mysql -u 1000 -g mysql && \
    dnf -y install mariadb-server pwgen psmisc net-tools hostname && \
    dnf clean all

ADD scripts /scripts
RUN chmod -v +x /scripts/*
ADD mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

VOLUME ["/var/lib/mysql"]
EXPOSE 3306

CMD ["/scripts/start.sh"]
