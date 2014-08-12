dockerfiles-fedora-registry
========================

Fedora dockerfile for docker registry

Get the version of Docker:

	# docker version

To build:

	# docker build --rm -t <yourname>/registry .

To run:

	# docker run -d -p 5000:5000 <yourname>/registry

To use a separate data volume for /var/lib/docker-registry (recommended, to
allow image update without losing registry contents):

Create a data volume container: (it doesn't matter what image you use
here, we'll never run this container again; it's just here to
reference the data volume)

	# docker run --name=registry-data -v /var/lib/docker-registry fedora true

And now create the registry application container:

	# docker run --name=registry  -d -p 5000:5000 --volumes-from=registry-data <yourname>/registry

Test it...

```
# docker tag <yourname>/registry localhost:5000/<yourname>/registry
# docker push localhost:5000/<yourname>/registry
```
