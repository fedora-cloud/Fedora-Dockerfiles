# Based on the Fedora image
FROM fedora

# File Author / Maintainer
MAINTAINER http://fedoraproject.org/wiki/Cloud
# based on the work of Takayoshi Kimura <tkimura@redhat.com>

ENV container docker
ENV MATTERMOST_VERSION 2.1.0

# Labels consumed by Red Hat build service
LABEL Component="mattermost" \
      Name="fedora-cloud/mattermost-210" \
      Version="2.1.0" \
      Release="1"

# Labels could be consumed by OpenShift
LABEL io.k8s.description="Mattermost is an open source, self-hosted Slack-alternative" \
      io.k8s.display-name="Mattermost 2.1.0" \
      io.openshift.expose-services="8065:mattermost" \
      io.openshift.tags="mattermost,slack"

# Labels could be consumed by Nulecule Specification
LABEL io.projectatomic.nulecule.environment.required="MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE" \
      io.projectatomic.nulecule.environment.optional="VOLUME_CAPACITY" \
      io.projectatomic.nulecule.volume.data="/var/lib/psql/data,1Gi"

RUN dnf update -y && \
    dnf install -y tar --setopt=tsflags=nodocs && \
    dnf clean all

RUN cd /opt && \
    curl -LO https://releases.mattermost.com/2.1.0/mattermost-team-2.1.0-linux-amd64.tar.gz && \
    tar xf mattermost-team-2.1.0-linux-amd64.tar.gz &&\
    rm mattermost-team-2.1.0-linux-amd64.tar.gz && \
    chmod -R 777 /opt/mattermost
# FIXME this seems to be too 777ish

COPY mattermost-launch.sh /usr/local/bin/mattermost-launch.sh
COPY config.json /opt/mattermost/config/config.json
RUN chmod 777 /opt/mattermost/config/config.json

# Make sure we can run with random UID, even in standalone docker
USER 2273
EXPOSE 8065

CMD mattermost-launch.sh
