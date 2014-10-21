dockerfiles-fedora-cups
========================

Fedora dockerfile for CUPS

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build-

```
# docker build --rm -t <username>/cups .
```

To run, assigning a random port that maps to port 631 on the
container:

```
# docker run -d -p 631:631 \
	-e CUPS_ADMIN_USER=user -e CUPS_ADMIN_PASSWORD=password \
	<username>/cups
```

To find the port that the container is listening on:

```
# docker ps
```

To use from the command line:

```
# lpstat -h localhost:49150 -t
```

View https://localhost:49150/ for the web interface.
