dockerfiles-fedora-hadoop-resourcemgr
=====================================

Fedora dockerfile for a Hadoop Resource Manager - Single container, single-service.  No external volume.

This was built and tested on a Fedora 20 host running Docker 0.9.0.

1. To build:

```
# docker build --rm -t <username>/hadoop-resourcemgr . |& tee hadoop_build.log
# docker images
```

2. To Run:

```
# ./run.sh
# docker ps
```

Make sure to replace <username> and <dns_ip> in the run.sh file.

3. To confirm ports are available:

```
# docker ps
CONTAINER ID        IMAGE                           COMMAND             CREATED             STATUS              PORTS        NAMES
de33e77a7d73        <username>/hadoop-resourcemgr:latest   supervisord -n      6 seconds ago       Up 4 seconds        8031/tcp, 8033/tcp, 0.0.0.0:8032->8032/tcp, 0.0.0.0:8088->8088/tcp, 8090/tcp, 8030/tcp, 8050/tcp, 8141/tcp, 8025/tcp   lonely_brattain
```

4. To access services, open a local browser and hit the following URLs.

```
	# curl http://localhost:8088/cluster - Resource manager
```
