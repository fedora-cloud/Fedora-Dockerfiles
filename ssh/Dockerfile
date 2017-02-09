FROM registry.fedoraproject.org/fedora:25
LABEL MAINTAINER='http://fedoraproject.org/wiki/Cloud'

ENV NAME=ssh VERSION=0.1 RELEASE=1
# Atomic RUN label, enables the atomic cli
LABEL RUN='docker run --name ssh -d -p 2200:22 $IMAGE' \
      BZComponent="$NAME" \
      Name="$FGC/$NAME" \
      Version="$VERSION" \
      Release="$RELEASE.$DISTTAG" \
      Architecture="$ARCH"

EXPOSE 22

RUN dnf -y update && dnf -y install openssh-server passwd && dnf clean all

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
