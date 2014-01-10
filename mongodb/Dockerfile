FROM fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update
RUN yum -y install mongodb-server
RUN mkdir -p /data/db

EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]

