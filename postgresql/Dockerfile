FROM index.docker.io/fedora
MAINTAINER Pavel Raiskup <praiskup@redhat.com>

ENV container="docker"

RUN dnf -y --setopt=tsflags=nodocs install postgresql-server \
    && dnf -y --setopt=tsflags=nodocs reinstall glibc-common \
    && dnf -y --setopt=tsflags=nodocs clean all --enablerepo='*'

ADD "root" \
    "/"

RUN systemctl disable getty.service console-getty.service \
    && systemctl enable postgresql-container.service \
    && ln -s /usr/bin/cont-postgresql-cmd /usr/bin/container-start \
    && touch /var/lib/pgsql/data/.container_internal && chown 26:26 /var/lib/pgsql/data \
    && container-build && rm /usr/bin/container-build

VOLUME \
    "/var/lib/pgsql/data"

EXPOSE 5432

USER postgres
ENTRYPOINT ["/usr/bin/container-entrypoint"]
CMD ["container-start"]
