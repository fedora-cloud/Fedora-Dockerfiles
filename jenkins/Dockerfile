FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install jenkins java initscripts supervisor && dnf clean all

EXPOSE 8080

RUN rm -rf /var/run/jenkins.pid

VOLUME ["/root/.jenkins"]

ADD ./supervisord.conf /etc/supervisord.conf

CMD [ "supervisord", "-n" ]
