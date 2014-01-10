FROM fedora
MAINTAINER scollier <scollier@redhat.com>

run         yum -y update
# run         yum -y install couchdb && /etc/init.d/couchdb stop
run         yum -y install couchdb 

run         sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /etc/couchdb/default.ini

expose      5984

cmd         ["/bin/sh", "-e", "/usr/bin/couchdb", "-a", "/etc/couchdb/default.ini", "-a", "/etc/couchdb/local.ini", "-b", "-r", "5", "-p", "/var/run/couchdb/couchdb.pid", "-o", "/dev/null", "-e", "/dev/null", "-R"]

