dockerfiles-fedora-redis
========================

Fedora Dockerfile for Redis, it implements a master and a sentinel (as shown by
	Kubernetes examples).

To build:

Copy the sources down -

	# docker build --rm -t <username>/redis .

To run:

	# docker run -d -p 6379:6379 -e MASTER=true <username>/redis

To test:

	# nc localhost 6379
