# dockerfiles-fedora-systemd-openssh

# Building & Running

Copy the sources to your docker host and build the container:

	# docker build --rm=true -t <username>/systemd-openssh .

To run:

	# docker run --privileged=true -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 22 <username>/systemd-openssh

Get the port that the container is listening on:

```
# docker ps
CONTAINER ID        IMAGE                           COMMAND             CREATED             STATUS              PORTS                                                 NAMES
917c8bf21311        <username>/systemd-openssh:latest   /usr/sbin/init      12 seconds ago      Up 8 seconds        0.0.0.0:49155->22/tcp                                 goofy_goldstine  
```

To test, use the port that was just located:

	# ssh -p xxxx user@localhost 

