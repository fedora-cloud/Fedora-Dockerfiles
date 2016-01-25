FROM fedora:rawhide
MAINTAINER http://fedoraproject.org/wiki/Cloud

EXPOSE 22

RUN dnf -y install \
	openssh-server \
	passwd \
	; dnf clean all

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
