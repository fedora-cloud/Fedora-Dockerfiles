FROM fedora:20
MAINTAINER Aditya Patawari <adimania@fedoraproject.org>

RUN yum clean all
RUN yum -y update; yum clean all
RUN yum -y install python-pip
RUN yum -y install python-django
RUN yum -y install git sqlite

EXPOSE 8000

CMD [ "/bin/bash" ]

