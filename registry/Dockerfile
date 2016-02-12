FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf update -y &&  dnf clean all
RUN dnf install -y docker-registry && dnf clean all
ADD run-registry.sh /opt/registry/run-registry.sh
RUN chmod -v 755 /opt/registry/run-registry.sh
CMD ["/opt/registry/run-registry.sh"]
EXPOSE 5000

