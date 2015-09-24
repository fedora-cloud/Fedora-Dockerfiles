FROM       fedora:22
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Perform updates
RUN dnf -y update && dnf clean all

# Install pandoc rpm
RUN dnf install -y pandoc && dnf clean all

# Set pandoc as our entrypoint
ENTRYPOINT ["/usr/bin/pandoc"]
CMD ["--help"]
