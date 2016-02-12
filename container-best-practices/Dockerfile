FROM fedora

MAINTAINER Scott Collier <scollier@redhat.com>

RUN dnf -y update && dnf clean all

RUN dnf -y install git asciidoc dockbook-xsl fop make && dnf clean all

WORKDIR /workdir

