FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum install -y python-qpid qpid-cpp-server && yum clean all

ADD . /.qpidd

WORKDIR /.qpidd

EXPOSE 5672

ENTRYPOINT ["qpidd", "-t", "--auth=no"]
