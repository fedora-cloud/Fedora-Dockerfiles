FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install 'dnf-command(config-manager)' && dnf clean all
RUN dnf config-manager --set-enabled updates-testing
RUN dnf -y install cadvisor && dnf clean all

EXPOSE 8080

CMD [ "/usr/bin/cadvisor" ]

