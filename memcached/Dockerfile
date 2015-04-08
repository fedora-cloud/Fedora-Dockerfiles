FROM  fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN  yum -y update && yum clean all
RUN yum -y install memcached && yum clean all

EXPOSE  11211

CMD  ["memcached", "-u", "daemon"]
