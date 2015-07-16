FROM  fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN  yum -y update && yum clean all
RUN yum -y install memcached && yum clean all
ADD start_memcached.sh /start_memcached.sh
RUN chmod 755 /start_memcached.sh

EXPOSE  11211

CMD  ["/start_memcached.sh"]
