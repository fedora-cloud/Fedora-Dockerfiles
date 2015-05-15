FROM index.docker.io/fedora
MAINTAINER Pavel Raiskup <praiskup@redhat.com>

ENV container="docker"

RUN yum -y --setopt=tsflags=nodocs install postgresql-server \
    && yum -y --setopt=tsflags=nodocs reinstall glibc-common \
    && yum -y --setopt=tsflags=nodocs clean all --enablerepo='*'

ADD root /

RUN systemctl disable getty.service console-getty.service \
    && systemctl enable postgresql-container.service \
    && ln -s /usr/bin/cont-postgresql-cmd /usr/bin/container-start \
    && chmod +x /usr/bin/container-build \
    && container-build \
    && rm -rf /usr/bin/container-build

VOLUME \
    "/var/lib/pgsql/data"

EXPOSE 5432

USER postgres

ENTRYPOINT ["/usr/bin/container-entrypoint"]

CMD ["container-start"]
