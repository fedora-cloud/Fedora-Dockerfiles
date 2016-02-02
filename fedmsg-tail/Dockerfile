FROM fedora:22
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf install -y fedmsg fedmsg-hub fedmsg-relay fedmsg-announce fedmsg-irc && \
    dnf update -y && \
    dnf clean all

CMD [ "fedmsg-tail", "--really-pretty" ]
