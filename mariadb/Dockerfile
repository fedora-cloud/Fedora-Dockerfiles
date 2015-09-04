FROM fedora:21
MAINTAINER http://fedoraproject.org/wiki/Cloud
RUN dnf -y update && dnf clean all
RUN dnf -y install mariadb-server pwgen psmisc net-tools hostname && \
    dnf clean all

ADD scripts /scripts
RUN chmod 755 /scripts/*

VOLUME ["/var/lib/mysql", "/var/log/mysql"]
EXPOSE 3306

CMD ["/bin/bash", "/scripts/start.sh"]
