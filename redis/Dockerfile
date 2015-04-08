FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum -y install redis && yum clean all

EXPOSE 6379

CMD [ "redis-server" ]

