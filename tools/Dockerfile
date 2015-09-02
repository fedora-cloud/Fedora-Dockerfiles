FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

ENV container docker
LABEL RUN="docker run -it --name NAME --privileged --ipc=host --net=host --pid=host -e HOST=/host -e NAME=NAME -e IMAGE=IMAGE -v /run:/run -v /var/log:/var/log -v /etc/localtime:/etc/localtime -v /:/host IMAGE"

RUN [ -e /etc/yum.conf ] && sed -i '/tsflags=nodocs/d' /etc/yum.conf || true

# Reinstall all packages to get man pages for them
RUN dnf -y reinstall "*" && dnf clean all

# Install all useful packages
RUN dnf -y install \
           abrt \
           bash-completion \
           bc \
           blktrace \
           btrfs-progs \
           crash \
           docker \
           docker-selinux \
           e2fsprogs \
           ethtool \
           file \
           findutils \
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
           ltrace \
           mailx \
           man-db \
           nc \
           net-tools \
           netsniff-ng \
           numactl \
           numactl-devel \
           ostree \
           p7zip \
           passwd \
           pciutils \
           pcp \
           perf \
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
           strace \
           subscription-manager \
           sysstat \
           systemtap \
           systemtap-client \
           tar \
           tcpdump \
           tcpdump \
           vim-enhanced \
           vim-minimal \
           which \
           xauth \
           dnf-plugins-core && dnf clean all

# Set default command
CMD ["/usr/bin/bash"]
