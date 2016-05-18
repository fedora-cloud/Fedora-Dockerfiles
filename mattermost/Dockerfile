# Based on the Fedora image
FROM fedora

# File Author / Maintainer
MAINTAINER http://fedoraproject.org/wiki/Cloud
# based on the work of Takayoshi Kimura <tkimura@redhat.com>

ENV container docker
ENV MATTERMOST_VERSION 3.0.1

# Labels consumed by Red Hat build service
LABEL Component="mattermost" \
      Name="fedora-cloud/mattermost-301" \
      Version="3.0.1" \
      Release="1"

# Labels could be consumed by OpenShift
LABEL io.k8s.description="Mattermost is an open source, self-hosted Slack-alternative" \
      io.k8s.display-name="Mattermost 3.0.1" \
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
    curl -LO https://releases.mattermost.com/3.0.1/mattermost-team-3.0.1-linux-amd64.tar.gz && \
    tar xf mattermost-team-3.0.1-linux-amd64.tar.gz && \
    rm mattermost-team-3.0.1-linux-amd64.tar.gz && \
    mkdir /opt/mattermost/data && \
    chmod 777 /opt/mattermost/config /opt/mattermost/logs /opt/mattermost/data

COPY mattermost-launch.sh /opt/mattermost/bin/mattermost-launch.sh
COPY config.json /opt/mattermost/config/config.json
RUN chmod 777 /opt/mattermost/config/config.json

EXPOSE 8065

WORKDIR /opt/mattermost

CMD bin/mattermost-launch.sh
