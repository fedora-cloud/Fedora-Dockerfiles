FROM fedora:21
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install yum-utils && dnf clean all
RUN yum-config-manager --enable updates-testing 
RUN dnf -y install cadvisor && dnf clean all

EXPOSE 8080

CMD [ "/usr/bin/cadvisor" ]

