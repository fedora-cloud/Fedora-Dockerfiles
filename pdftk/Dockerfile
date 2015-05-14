# pdftk was last packaged for Fedora 20
FROM       fedora:20
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Perform updates
RUN yum -y update && yum clean all

# Install owncloud owncloud-httpd owncloud-sqlite rpms
RUN yum install -y pdftk && yum clean all

# Set pdftk as our entrypoint
ENTRYPOINT ["/usr/bin/pdftk"]
CMD ["--help"]

