FROM fedora
MAINTAINER Aditya Patawari <adimania@fedoraproject.org>

RUN yum -y update
RUN yum -y install redis

EXPOSE 6379

CMD [ "redis-server" ]

