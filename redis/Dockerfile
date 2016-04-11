FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

LABEL io.k8s.description="Redis is an open source, in-memory data structure store, used as database, cache and message broker." \
      io.k8s.display-name="Redis 3.0.6-1.fc23" \
      io.openshift.expose-services="6379:redis" \
      io.openshift.tags="database,redis,redis28"

LABEL Name="fedora-cloud/redis-28" \
      Version="3.0.6" \
      Release="1" \
      Architecture="x86_64"

RUN dnf -y --setopt=tsflags=nodocs update && \
    dnf -y --setopt=tsflags=nodocs install redis && \
    dnf clean all

COPY redis-master.conf /redis-master/redis.conf
COPY redis-slave.conf /redis-slave/redis.conf
COPY entrypoint /entrypoint
RUN mkdir /redis-master-data && \
    chmod 755 /entrypoint /redis-master-data && \
    chown 997 /redis-master-data

EXPOSE 6379

# By default will run as random user on openshift and the redis user (997)
# everywhere else
USER 997

CMD [ "/entrypoint" ]
ENTRYPOINT [ "sh", "-c" ]
