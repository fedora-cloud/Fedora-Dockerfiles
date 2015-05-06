FROM fedora:21

MAINTAINER Scott Collier <scollier@redhat.com>

RUN yum -y update && yum clean all 

RUN yum -y install git asciidoc dockbook-xsl fop make && yum clean all

WORKDIR /workdir

