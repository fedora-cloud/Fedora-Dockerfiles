FROM fedora:21
MAINTAINER "Lalatendu Mohanty" <lmohanty@redhat.com>

RUN yum -y update && yum clean all
RUN yum -y install jenkins java initscripts supervisor && yum clean all

EXPOSE 8080

RUN rm -rf /var/run/jenkins.pid

VOLUME ["/root/.jenkins"]

ADD ./supervisord.conf /etc/supervisord.conf

CMD [ "supervisord", "-n" ]
