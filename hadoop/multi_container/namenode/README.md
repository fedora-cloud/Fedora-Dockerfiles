dockerfiles-fedora-hadoop-namenode
==================================

Fedora dockerfile for a Hadoop Namenode - Single container, single-service.  No external volume.

This was built and tested on a Fedora 20 host running Docker 0.9.0.

1. To build:

```
	# docker build --rm -t <username>/hadoop-namenode . |& tee hadoop_build.log
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
de33e77a7d73        <username>/hadoop-namenode:latest   supervisord -n      6 seconds ago       Up 4 seconds        0.0.0.0:50070->50070/tcp, 50090/tcp, 50470/tcp, 8020/tcp, 9000/tcp   romantic_morse
```

4. To access services, open a local browser and hit the following URLs.

```
	# curl http://localhost:50070 - Namenode
```
