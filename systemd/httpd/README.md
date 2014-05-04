dockerfiles-fedora-systemd
========================

Fedora dockerfile for apache working with systemd

Tested on Docker 0.10.0

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build-

```
# docker build -t rawhide_httpd .
```

To run docker in a container you need to mount cgroup file system volume:

```
docker run --rm --privileged -p 80:80 -ti -e 'container=docker' -v
/sys/fs/cgroup:/sys/fs/cgroup:ro rawhide_httpd

```

To confirm the port that the container is listening on:

```
# docker ps
```

To test:

```
# curl http://localhost

