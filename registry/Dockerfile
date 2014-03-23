FROM fedora
MAINTAINER Stephen Tweedie <sct@redhat.com>

RUN yum update -y
RUN yum install -y docker-registry
ADD run-registry.sh /opt/registry/run-registry.sh
RUN chmod -v 755 /opt/registry/run-registry.sh
CMD ["/opt/registry/run-registry.sh"]
EXPOSE 5000

