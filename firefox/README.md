dockerfiles-fedora-firefox
==========================

Fedora dockerfile for Firefox over VNC

Get the version of Docker

```
# docker version
```

To build:

Copy the sources down -

```
# docker build --rm -t <username>/firefox .
```

To run:

```
# docker run -d -p 5901:5901 <username>/firefox
```

Check the that the image launched successfully

```
# docker ps
CONTAINER ID        IMAGE                     COMMAND             CREATED             STATUS              PORTS                    NAMES
b1296df1a4e8        scollier/firefox:latest   vncserver -fg       3 seconds ago       Up 1 seconds        0.0.0.0:5901->5901/tcp   angry_brown         
```

To test -

From the host that is running the container -

```
# vncviewer localhost:1
```

That's it.
