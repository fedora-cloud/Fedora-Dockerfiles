dockerfiles-fedora-mesos-slave
==============================

Fedora dockerfile for a Mesos Slave - Single container, single-service.  No external volume.

This was built and tested on a Fedora 20 host running Docker 0.9.0.

1. To build:

```
	# docker build --rm -t <username>/mesos-slave .
	# docker images
```

2. To Run:

```
	# docker run --link master:mesos_master -d -t <username>/mesos-slave
	# docker ps
```

3. To confirm ports are available:

```
# docker ps
CONTAINER ID        IMAGE                           COMMAND             CREATED             STATUS              PORTS        NAMES
de33e77a7d73        <username>/mesos-slave:latest   supervisord -n      6 seconds ago       Up 4 seconds        5051/tcp   romantic_morse
```
