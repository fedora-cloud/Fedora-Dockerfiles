FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

EXPOSE 22

RUN yum -y install \
	openssh-server \
	passwd \
	; yum clean all

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
