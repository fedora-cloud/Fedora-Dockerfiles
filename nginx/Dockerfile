FROM registry.fedoraproject.org/fedora:25
LABEL MAINTAINER='http://fedoraproject.org/wiki/Cloud'

ENV NAME=nginx VERSION=0.1 RELEASE=1
# Atomic RUN label, enables the atomic cli
LABEL RUN='docker run --name nginx -d -p 80:80 $IMAGE' \
      BZComponent="$NAME" \
      Name="$FGC/$NAME" \
      Version="$VERSION" \
      Release="$RELEASE.$DISTTAG" \
      Architecture="$ARCH"


RUN dnf -y update && dnf -y install nginx && dnf clean all
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "nginx on Fedora" > /usr/share/nginx/html/index.html

EXPOSE 80

CMD [ "/usr/sbin/nginx" ]

