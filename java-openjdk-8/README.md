dockerfiles-fedora-java
========================

Fedora dockerfile for java development 

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build

```
# docker build --rm -t <username>/fedora_java .
```

Run or verify the image

```
# docker run -it --rm <username>/fedora_java java -version
```

