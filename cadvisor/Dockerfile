FROM fedora
MAINTAINER atomic-devel@projectatomic.io

RUN yum -y update && yum -y install cadvisor && yum clean all

EXPOSE 8080

CMD [ "/usr/bin/cadvisor" ]

