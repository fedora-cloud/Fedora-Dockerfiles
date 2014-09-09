FROM fedora:rawhide
MAINTAINER scollier <emailscottcollier@gmail.com>

# Update the container
RUN yum -y update && yum clean all

# Install mesos
RUN yum -y install mesos mesos-java python-mesos && yum clean all

# Install some support packages
RUN yum -y install supervisor bash-completion && yum clean all

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN yum -y install net-tools lsof nmap && yum clean all

ADD ./supervisord.conf /etc/supervisord.conf
ADD ./mesos-daemon.sh /usr/sbin/mesos-daemon.sh

RUN chmod 755 /usr/sbin/mesos-daemon.sh

EXPOSE 5050

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
