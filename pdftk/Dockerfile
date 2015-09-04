# pdftk was last packaged for Fedora 20
FROM       fedora:20
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Perform updates
RUN dnf -y update && dnf clean all

# Install owncloud owncloud-httpd owncloud-sqlite rpms
RUN dnf install -y pdftk && dnf clean all

# Set pdftk as our entrypoint
ENTRYPOINT ["/usr/bin/pdftk"]
CMD ["--help"]

