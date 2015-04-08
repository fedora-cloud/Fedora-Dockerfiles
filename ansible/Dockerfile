FROM fedora:latest
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all

RUN yum -y install ansible && yum clean all
RUN mkdir -p /etc/ansible/roles \
        && echo '[local]\nlocalhost\n' > /etc/ansible/hosts

ENV ANSIBLE_NOCOWS 1

CMD ansible localhost -m setup
