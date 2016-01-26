FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum -y install yum-utils && yum clean all
RUN yum-config-manager --enable updates-testing 
RUN yum -y install cadvisor && yum clean all

EXPOSE 8080

CMD [ "/usr/bin/cadvisor" ]

