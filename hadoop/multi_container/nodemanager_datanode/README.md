dockerfiles-fedora-hadoop-datanode
==================================

Fedora dockerfile for a Hadoop Datanode - Single container, multi-service.  No external volume.

This was built and tested on a Fedora 20 host running Docker 0.9.0.

1. To build:

```
	# docker build --rm=true -t <username>/hadoop-datanode . |& tee hadoop_build.log
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
de33e77a7d73        <username>/hadoop-datanode:latest   supervisord -n      6 seconds ago       Up 4 seconds        0.0.0.0:50075->50075/tcp, 0.0.0.0:8042->8042/tcp, 45454/tcp, 50010/tcp, 50020/tcp, 50475/tcp, 8010/tcp, 8040/tcp   angry_bohr
```

4. To access services, open a local browser and hit the following URLs.

```
	# curl http://localhost:50075 - Datanode
	# curl http://localhost:8042 - Yarn node manager
```
