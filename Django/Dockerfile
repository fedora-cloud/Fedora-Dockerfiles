FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all
RUN dnf -y install python-pip python-django git sqlite python-psycopg2 && dnf clean all

# create directory /code and mount sources there
RUN mkdir /code
WORKDIR /code
VOLUME /code

EXPOSE 8000

CMD python manage.py runserver 0.0.0.0:8000
