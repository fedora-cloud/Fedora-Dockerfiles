FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install community-mysql-server community-mysql pwgen supervisor bash-completion psmisc net-tools && dnf clean all

ADD scripts /scripts

# RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers

RUN chmod 755 /scripts/*

EXPOSE 3306

CMD ["/bin/bash", "/scripts/start.sh"]
