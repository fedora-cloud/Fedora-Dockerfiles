FROM fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update; yum clean all
RUN yum -y install pwgen wget logrotate; yum clean all
RUN yum install -y http://www.rabbitmq.com/releases/rabbitmq-server/v3.3.0/rabbitmq-server-3.3.0-1.noarch.rpm
RUN /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management

#
# add run/set passwd script
ADD run-rabbitmq-server.sh /run-rabbitmq-server.sh
RUN chmod 750 ./run-rabbitmq-server.sh

# 
# expose some ports
#
# 5672 rabbitmq-server - amqp port
# 15672 rabbitmq-server - for management plugin
# 4369 epmd - for clustering
# 25672 rabbitmq-server - for clustering
EXPOSE 5672 15672 4369 25672

#
# entrypoint/cmd for container
# we will set a random password and add one vhost for development
ENV DEVEL_VHOST_NAME develop

CMD ["/run-rabbitmq-server.sh"]
