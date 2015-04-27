FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all

# List of packages that may be needed while troubleshooting, including the MongoDB client. Only uncomment this line if you need the MongoDB client while inside the container.
# RUN yum -y install mongodb mongodb-server && yum clean all

# Final package install once everything is working.  Once everything is working, the intent is to use the MongoDB client from outside the container. You need either this line, or the previous package install line, but  not both.
RUN yum -y install mongodb-server && yum clean all
RUN mkdir -p /data/db

EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]

