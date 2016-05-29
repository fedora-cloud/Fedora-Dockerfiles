FROM docker.io/fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

ENV container docker
LABEL RUN="docker run -it --name NAME --privileged --ipc=host --net=host --pid=host -e HOST=/host -e NAME=NAME -e IMAGE=IMAGE -v /run:/run -v /var/log:/var/log -v /etc/localtime:/etc/localtime -v /:/host IMAGE"

RUN [ -e /etc/yum.conf ] && sed -i '/tsflags=nodocs/d' /etc/yum.conf || true

# Reinstall all packages to get man pages for them
RUN dnf -y update && dnf -y reinstall "*" && dnf clean all

# Install all useful packages
RUN dnf -y remove vim-minimal && \
    dnf -y install \
           abrt \
           bash-completion \
           bc \
           blktrace \
           btrfs-progs \
           crash \
           dnf-plugins-core \
           docker \
           docker-selinux \
           e2fsprogs \
           ethtool \
           file \
           findutils \
           fpaste \
           gcc \
           gdb \
           gdb-gdbserver \
           git \
           glibc-common \
           glibc-utils \
           hwloc \
           iotop \
           iproute \
           iputils \
           kernel \
           kubernetes-client \
           kubernetes-devel \
           kubernetes-master \
           kubernetes-node \
           less \
           ltrace \
           mailx \
           man-db \
           nc \
           netsniff-ng \
           net-tools \
           numactl \
           numactl-devel \
           ostree \
           passwd \
           pciutils \
           pcp \
           perf \
           procps-ng \
           psmisc \
           python-dnf-plugins-extras* \
           python-docker-py \
           python-rhsm \
           rootfiles \
           rpm-ostree \
           screen \
           sos \
           strace \
           subscription-manager \
           sysstat \
           systemtap \
           systemtap-client \
           tar \
           tcpdump \
           vim-enhanced \
           which \
           xauth \
           && dnf clean all

# Set default command
CMD ["/usr/bin/bash"]
