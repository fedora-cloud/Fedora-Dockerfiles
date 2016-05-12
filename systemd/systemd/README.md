dockerfiles-fedora-systemd
========================

Fedora dockerfile for systemd

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build-

```
# docker build -t <username>/systemd .
```

To run docker in a container you need to mount cgroup file system volume:

```
# docker run --rm -ti \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro <username>/systemd /bin/bash
```

To test once inside the container, check and see if systemd is working:

```
# /lib/systemd/systemd --system
```
