FROM fedora:rawhide
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Update the container
RUN dnf -y update && dnf clean all

# Install mesos
RUN dnf -y install mesos mesos-java python-mesos && dnf clean all

# Install some support packages
RUN dnf -y install supervisor bash-completion && dnf clean all

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN dnf -y install net-tools lsof nmap && dnf clean all

ADD ./supervisord.conf /etc/supervisord.conf
ADD ./mesos-daemon.sh /usr/sbin/mesos-daemon.sh
ADD ./mesos-slave-env.sh /etc/mesos/mesos-slave-env.sh

RUN chmod 755 /usr/sbin/mesos-daemon.sh

RUN mkdir /var/run/mesos
RUN chown mesos.mesos /var/run/mesos
RUN chmod 0775 /var/run/mesos

EXPOSE 5050 5051

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
