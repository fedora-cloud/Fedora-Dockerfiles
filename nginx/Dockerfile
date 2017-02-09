FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# This Label adds ability to run image with atomic command
LABEL RUN='docker run -d -p 80:80 $IMAGE'

RUN dnf -y update && dnf clean all
RUN dnf -y install nginx && dnf clean all
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN echo "nginx on Fedora" > /usr/share/nginx/html/index.html

EXPOSE 80

CMD [ "/usr/sbin/nginx" ]

