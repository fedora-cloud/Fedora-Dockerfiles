FROM fedora:20
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum -y install python-pip python-django git sqlite && yum clean all

EXPOSE 8000

CMD [ "/bin/bash" ]

