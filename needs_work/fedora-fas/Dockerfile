# FAS installation process based on https://github.com/docent-net/fas/blob/develop/INSTALL
# Docker image based on the Fedora image
FROM fedora

MAINTAINER "Maciej Lasyk" <maciek@lasyk.info>

# install main packages:
RUN yum -y update
RUN yum -y install make gcc

# firstly let's install postgres - following scollier's Dockerfile from https://git.fedorahosted.org/cgit/dockerfiles.git/tree/postgres
RUN yum -y install postgresql-server postgresql postgresql-contrib supervisor
ADD ./postgresql-setup /usr/bin/postgresql-setup
ADD ./postgres_user.sh /postgres_user.sh
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

RUN chmod +x /usr/bin/postgresql-setup
RUN chmod +x /start_postgres.sh
RUN chmod +x /postgres_user.sh

RUN /usr/bin/postgresql-setup initdb

ADD ./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chown -v postgres:postgres /var/lib/pgsql/data/postgresql.conf

RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf

RUN /postgres_user.sh

# now let's install FAS:
RUN yum -y install git-core postgresql-plpython postgresql-server postgresql-python python-TurboMail TurboGears pygpgme python-sqlalchemy python-genshi python-psycopg4 pytz python-babel babel python-GeoIP python-openid python-fedora-turbogears python-migrate python-memcached python-tgcaptcha2 pyOpenSSL gettext python-imaging python-pwquality tulrich-tuffy-fonts

RUN useradd fedora-dev

RUN mkdir /srv -p
WORKDIR /srv
RUN git clone https://github.com/fedora-infra/fas.git

WORKDIR /srv/fas
RUN python setup.py egg_info && python setup.py build

RUN chown fedora-dev:fedora-dev /srv/fas -R

USER postgres
RUN /start_postgres.sh & &>/dev/null
#RUN /usr/bin/postgres -D /var/lib/pgsql/data -p 5432 & &>/dev/null
#RUN createlang plpythonu template1

USER fedora-dev
RUN cp fas2.sql /tmp

USER postgres
RUN psql < /tmp/fas2.sql

USER fedora-dev
RUN rm -f /tmp/fas2.sql
RUN cp fas.cfg.sample fas.cfg

#RUN mv fas.cfg.sample fas.cfg
