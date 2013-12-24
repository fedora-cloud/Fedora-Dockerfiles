dockerfiles-fedora-httpd
========================

Fedora dockerfile for httpd

Tested on Docker 0.7.0

To build:

Over the net via git -

```
docker build -rm -t <username>/httpd git://github.com/scollier/dockerfiles-fedora-apache.git
```

or

Copy the sources down and do the build-

```
docker build -rm -t <username>/httpd .
```


To run (if port 80 is open on your host):

```
docker run -d -p 80:80 <username>/httpd
```

or to assign a random port that maps to port 80 on the container:

```
docker run -d -p 80 <username>/httpd
```

To the port that the container is listening on:

```
docker ps
```

To test:

```
curl http://localhost
```
