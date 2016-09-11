FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Updating dependencies, installing irssi and cleaning dnf caches to reduce container size
RUN dnf -y update && dnf -y install irssi && dnf clean all

ADD atomic-* /root/
RUN chmod -v +x /root/atomic-*

LABEL RUN /usr/bin/docker run -ti --rm --pid=host --privileged -v /:/host IMAGE /root/atomic-run

CMD ["/root/atomic-run"]
