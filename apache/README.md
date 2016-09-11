dockerfiles-fedora-httpd
========================

Built on : Docker version 1.9.1
Run on: Docker version 1.9.1
Tested on : Docker version 1.9.1

Fedora dockerfile for httpd

Get Docker version

```
# docker version
```

To run the image in the registry (assuming port 80 is open):

```
# sudo atomic RUN docker.io/fedora/apache
```

The atomic application will pull the image and run it.


To build:

Copy the sources down and do the build-

```
# docker build --rm -t <username>/httpd .
```

To run a local build (if port 80 is open on your host):

```
# docker run -d -p 80:80 <username>/httpd
```

or to assign a random port that maps to port 80 on the container:

```
# docker run -d -p 80 <username>/httpd
```

To the port that the container is listening on:

```
# docker ps
```

To test:

```
# curl http://localhost
```
