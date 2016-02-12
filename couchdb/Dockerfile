FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN  dnf -y update && dnf clean all
RUN  dnf -y install couchdb && dnf clean all

RUN  sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /etc/couchdb/default.ini

EXPOSE  5984

CMD ["/bin/sh", "-e", "/usr/bin/couchdb", "-a", "/etc/couchdb/default.ini", "-a", "/etc/couchdb/local.ini", "-b", "-r", "5", "-p", "/var/run/couchdb/couchdb.pid", "-o", "/dev/null", "-e", "/dev/null", "-R"]

