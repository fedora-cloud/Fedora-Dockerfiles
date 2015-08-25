FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

ENV container docker
LABEL RUN="docker run -it --name NAME --privileged --ipc=host --net=host --pid=host -e HOST=/host -e NAME=NAME -e IMAGE=IMAGE -v /run:/run -v /var/log:/var/log -v /etc/localtime:/etc/localtime -v /:/host IMAGE"

RUN [ -e /etc/yum.conf ] && sed -i '/tsflags=nodocs/d' /etc/yum.conf || true

# Reinstall all packages to get man pages for them
RUN dnf -y reinstall "*" && dnf clean all

# Install all useful packages
RUN dnf -y install \
           kernel \
           e2fsprogs \
           sos \
           crash \
           strace \
           ltrace \
           tcpdump \
           abrt \
           pcp \
           systemtap \
           perf \
           bc \
           blktrace \
           btrfs-progs \
           ethtool \
           file \
           findutils \
           gcc \
           gdb \
           git \
           glibc-common \
           glibc-utils \
           hwloc \
           iotop \
           iproute \
           iputils \
           less \
           pciutils \
           ltrace \
           mailx \
           man-db \
           nc \
           netsniff-ng \
           net-tools \
           numactl \
           numactl-devel \
           passwd \
           perf \
           procps-ng \
           psmisc \
           screen \
           strace \
           sysstat \
           systemtap-client \
           tar \
           tcpdump \
           vim-enhanced \
           xauth \
           which \
           ostree \
           rpm-ostree \
           docker \
           python-docker-py \
           docker-selinux \
           kubernetes-client \
           kubernetes-node \
           kubernetes-devel \
           kubernetes-master \
           gdb-gdbserver \
           vim-minimal \
           bash-completion \
           subscription-manager \
           python-rhsm \
           rootfiles \
           python-dnf-plugins-extras* \
           dnf-plugins-core && dnf clean all

# Set default command
CMD ["/usr/bin/bash"]
