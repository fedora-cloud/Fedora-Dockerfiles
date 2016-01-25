FROM fedora:latest
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all

RUN dnf -y install ansible && dnf clean all
RUN mkdir -p /etc/ansible/roles \
        && echo '[local]\nlocalhost\n' > /etc/ansible/hosts

ENV ANSIBLE_NOCOWS 1

CMD ansible localhost -m setup
