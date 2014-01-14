FROM fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update
RUN yum -y install community-mysql-server community-mysql pwgen supervisor bash-completion openssh-server psmisc net-tools

ADD ./start.sh /start.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN echo %sudo	ALL=NOPASSWD: ALL >> /etc/sudoers

RUN chmod 755 /start.sh
RUN mkdir /var/run/sshd

EXPOSE 3306 22

CMD ["/bin/bash", "/start.sh"]
