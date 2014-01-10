FROM fedora
MAINTAINER scollier <scollier@redhat.com>

RUN yum -y update
RUN yum -y install postgresql-server postgresql postgresql-contrib supervisor

ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./postgres_user.sh /postgres_user.sh
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh
ADD ./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chmod +x /usr/bin/postgresql-setup
RUN chmod +x /start_postgres.sh
RUN chmod +x /postgres_user.sh

RUN /usr/bin/postgresql-setup initdb

RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf

RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf

RUN /postgres_user.sh

EXPOSE 5432

CMD ["/bin/bash", "/start_postgres.sh"]
