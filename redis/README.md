dockerfiles-fedora-redis
========================

Fedora dockerfile for redis

To build:

Copy the sources down -

	# docker build --rm -t fedora/redis .

To run:

On Atomic host:

        # atomic run fedora/redis

Non-Atomic host:

	# docker run -d -p 6379:6379 fedora/redis

To test:

	# nc localhost 6379

