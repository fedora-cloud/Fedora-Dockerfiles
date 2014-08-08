dockerfiles-fedora-redis
========================

Fedora dockerfile for redis

To build:

Copy the sources down -

	# docker build -rm -t <username>/redis .

To run:

	# docker run -d -p 6379:6379 <username>/redis

To test:

	# nc localhost 6379

