FROM mattdm/fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update
RUN yum -y install postgresql-server postgresql postgresql-contrib sudo
RUN postgresql-setup initdb
RUN su - postgres -c "/usr/bin/postgres"
RUN postgres -c "createuser -P -d -r -s docker"
RUN postgres -c "createdb -O docker"

RUN echo "host    all             all             0.0.0.0/0               md5
" >> /var/lib/pgsql/data/pg_hba.conf

RUN sed -i 's/localhost/\*/g' /var/lib/pgsql/data/postgresql.conf

EXPOSE 22
CMD ["/bin/bash", "/start.sh"]
