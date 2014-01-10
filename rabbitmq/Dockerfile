FROM fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update
RUN yum -y install wget logrotate rabbitmq-server
RUN /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management

EXPOSE 5672 15672
ENTRYPOINT ["/usr/sbin/rabbitmq-server"]
