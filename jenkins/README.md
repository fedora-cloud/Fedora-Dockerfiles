dockerfiles-fedora-jenkins
========================

Fedora dockerfile for jenkins

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build

```
# docker build --rm -t <username>/fedora_jenkins .
```

To run (if port 8080 is open on your host):

```
docker run -p 8080:8080 -d <username>/fedora_jenkins
```

or to assign a random port that maps to port 80 on the container:

```
# docker run -d -p 8080 <username>/fedora_jenkins
```

To the port that the container is listening on:

```
# docker ps
```

To test:

```
# open http://localhost:<port> in a web browser

# <port> : The port of docker host to which container's port is mapped
```
