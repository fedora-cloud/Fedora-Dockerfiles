from        mattdm/fedora
maintainer  scollier <scollier@redhat.com>

run         yum -y update
run         yum -y install memcached

expose      11211

cmd         ["memcached", "-u", "daemon"]
