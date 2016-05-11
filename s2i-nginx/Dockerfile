FROM fedora

MAINTAINER http://fedoraproject.org/wiki/Cloud

ENV NGINX_VERSION="1.8"

LABEL io.k8s.description="Platform for building nginx-based application (aka static content)" \
      io.k8s.display-name="Nginx 1.8 builder" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,nginx,nginx18" \
      Name="fedora-cloud/s2i-nginx" \
      Version="1.8" \
      Release="1" \
      Architecture="x86_64"

RUN dnf install --setopt=tsflags=nodocs -y bcrypt nginx && \
    dnf update -y && \
    dnf clean all -y && \
    mkdir -p /opt/app-root/etc/nginx.conf.d && \
    chmod -R a+rx  /var/lib/nginx && \
    chmod -R a+rwX /var/lib/nginx/tmp \
                   /var/log \
                   /var/run

ENV STI_SCRIPTS_PATH="/usr/libexec/s2i" \
    STI_SCRIPTS_URL="image:///usr/libexec/s2i"

COPY ./etc/ /opt/app-root/etc
COPY ./.s2i/bin/ ${STI_SCRIPTS_PATH}

RUN cp /opt/app-root/etc/nginx.server.sample.conf /opt/app-root/etc/nginx.conf.d/default.conf && \
    chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

CMD ["usage"]
