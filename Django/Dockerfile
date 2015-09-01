FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install python-pip python-django git sqlite python-psycopg2 && dnf clean all

EXPOSE 8000

CMD [ "/bin/bash" ]

