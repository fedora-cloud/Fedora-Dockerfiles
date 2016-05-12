FROM fedora:23
LABEL Component="openscap-daemon" \
      Name="fedora-cloud/atomic-scan-openscap" \
      Version="0.1" \
      Release="0"

ENV container docker
RUN dnf -y install dnf-plugins-core &&  dnf config-manager --set-enabled updates-testing && \
    dnf -y install \
                openscap-containers \
                openscap-daemon \
                scap-security-guide \
                wget && \
    dnf clean all

ADD install.sh /root/
ADD run.sh /root/
ADD atomic_scan_openscap /root/
ADD config.ini /root

LABEL INSTALL="docker run --rm --privileged -v /:/host/ IMAGE sh /root/install.sh"

LABEL RUN="docker run -it --rm -v /:/host/ IMAGE sh /root/run.sh"

# Dockerfile reference discourages "ADD" with remote source
# I would love to tag this with NOCACHE but Dockerfile doesn't have an
# instruction for that. Instead the person building it has to use --no-cache

RUN wget --no-verbose -P /var/lib/oscapd/cve_feeds/ \
    https://www.redhat.com/security/data/oval/com.redhat.rhsa-RHEL{5,6,7}.xml.bz2 && \
    bzip2 -dk /var/lib/oscapd/cve_feeds/com.redhat.rhsa-RHEL{5,6,7}.xml.bz2
