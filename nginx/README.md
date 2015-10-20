dockerfiles-fedora-nginx
========================

Fedora Dockerfile for nginx

# Build the docker image

Clone the [Fedora Dockerfiles github repository](https://github.com/fedora-cloud/Fedora-Dockerfiles.git)
and build the container image by using:

```
# docker build --rm -t <username>/nginx .
```

# Running the image

```
# docker run -d -p 80:80 \
 -v <localdir>:/srv/www/logs \
 -v <localdir>:/srv/www/sites/enabled \
 <username>/nginx
```

If you provide a [Nginx site configuration](http://nginx.org/en/docs/beginners_guide.html#static)
at `/srv/www/sites/enabled/` it will be included by the container.

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
| `/srv/www/logs/` | Nginx logs |
| `/srv/www/sites/enabled/` | Nginx configuration files per site |

**Notice: When mounting a directory from the host into the container, ensure
that the mounted directory has the appropriate permissions and that the
owner and group of the directory matches the user UID or name which is
running inside the container.**

# Testing the container

```
# curl http://localhost
```
