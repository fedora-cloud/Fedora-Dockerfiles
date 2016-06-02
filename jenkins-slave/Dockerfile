FROM fedora:latest
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install java-1.8.0-openjdk openssh-server && dnf clean all

RUN ssh-keygen -A
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

RUN mkdir -p /var/run/sshd
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd



EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

