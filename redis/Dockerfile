FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install redis && dnf clean all

# This Label is used to run the image with atomic command
LABEL RUN='docker run -d -p 6379:6379 $IMAGE'

EXPOSE 6379

CMD [ "redis-server" ]

