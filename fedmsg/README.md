dockerfiles-fedora-fedmsg
========================

Fedora Dockerfile for fedmsg

# Build the docker image

Clone the [Fedora Dockerfiles github repository](https://github.com/fedora-cloud/Fedora-Dockerfiles.git)
and build the container image by using:

```
# docker build --rm -t <username>/fedmsg .
```

# Running the image

```
# docker run --rm <username>/fedmsg
```

The default command executed within the container is `fedmsg-tail --really-pretty`.

## Environment variables

The image recognizes the following environment variables that you can set
during initialization by passing `-e VAR=VALUE` to the Docker run command.

|   Variable name          |    Description                              |
|:------------------------ | -----------------------------------------   |
| NONE  | N/A |

You can also set the following mount points by passing the
`-v /host:/container` flag to Docker.

| Volume mount point         | Description            |
|:-------------------------- | ---------------------- |
| NONE | N/A |

**Notice: When mounting a directory from the host into the container, ensure
that the mounted directory has the appropriate permissions and that the
owner and group of the directory matches the user UID or name which is
running inside the container.**

# Testing the container

If you run the container as shown above, there should be some fedmsg output
within a few seconds.
