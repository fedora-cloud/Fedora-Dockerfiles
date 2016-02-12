FROM  fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN  dnf -y update && dnf clean all
RUN dnf -y install memcached && dnf clean all
ADD start_memcached.sh /start_memcached.sh
RUN chmod 755 /start_memcached.sh

EXPOSE  11211

CMD  ["/start_memcached.sh"]
