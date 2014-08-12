dockerfiles-fedora-mesos-master
===============================

Fedora dockerfile for a Mesos Master - Single container, single-service.  No external volume.

This was built and tested on a Fedora 20 host running Docker 0.9.0.

1. To build:

```
	# docker build --rm -t <username>/mesos-master .
	# docker images
```

2. To Run:

```
	# docker run --name master -d -p 5050:5050 -t <username>/mesos-master
	# docker ps
```

3. To confirm ports are available:

```
# docker ps
CONTAINER ID        IMAGE                           COMMAND             CREATED             STATUS              PORTS        NAMES
de33e77a7d73        <username>/mesos-master:latest   supervisord -n      6 seconds ago       Up 4 seconds        0.0.0.0:5050->5050/tcp   romantic_morse
```

4. To access services, open a local browser and hit the following URLs.

```
	# curl http://localhost:5050 - Master
```
