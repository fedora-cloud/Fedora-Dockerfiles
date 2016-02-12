FROM index.docker.io/fedora:23
MAINTAINER Pavel Raiskup <praiskup@redhat.com>

ENV container="docker"

LABEL INSTALL="docker run -t -i --rm --privileged -u 0:0 -v /:/host --net=host --ipc=host --pid=host -e HOST=/host -e LOGDIR=/var/log/\"\${NAME}\" -e DATADIR=/var/lib/\"\${NAME}\" -e CONFDIR=/etc/\"\${NAME}\" -e IMAGE=\"\${IMAGE}\" -e NAME=\"\${NAME}\" -e OPT1 -e OPT2 -e OPT3 \${OPT2} \${IMAGE} /usr/share/cont-postgresql/atomic/install.sh" \
    UNINSTALL="docker run -t -i --rm --privileged -u 0:0 -v /:/host --net=host --ipc=host --pid=host -e HOST=/host -e LOGDIR=/var/log/\"\${NAME}\" -e DATADIR=/var/lib/\"\${NAME}\" -e CONFDIR=/etc/\"\${NAME}\" -e IMAGE=\"\${IMAGE}\" -e NAME=\"\${NAME}\" -e OPT1 -e OPT2 -e OPT3 \${OPT2} \${IMAGE} /usr/share/cont-postgresql/atomic/uninstall.sh"

RUN dnf -y --setopt=tsflags=nodocs install postgresql-server \
    && dnf -y --setopt=tsflags=nodocs update glibc-common \
    && dnf -y --setopt=tsflags=nodocs reinstall glibc-common \
    && dnf -y --setopt=tsflags=nodocs clean all --enablerepo='*'

ADD "root" \
    "/"

RUN systemctl disable getty.service console-getty.service \
    && systemctl enable postgresql-container.service \
    && touch /var/lib/pgsql/data/.container_internal && chown 26:26 /var/lib/pgsql/data \
    && container-build && rm /usr/bin/container-build

VOLUME \
    "/var/lib/pgsql/data"

EXPOSE 5432

USER postgres
ENTRYPOINT ["/usr/bin/container-entrypoint"]
CMD ["container-start"]
