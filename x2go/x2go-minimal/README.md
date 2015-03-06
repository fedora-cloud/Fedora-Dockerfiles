# dockerfiles-fedora-x2go

To build:
Copy the sources to your docker host and build the container:
	# docker build --rm -t <username>/x2go .

The rest of these instructions assume you are OK with it using port 50000 on the host.

To run:
	# docker run -d -p 50000:22 --privileged=true <username>/x2go

To test:
	# ssh -p 50000 user@localhost

To use:
log in with X2Go Client, PyHoca-GUI, or PyHoca-CLI:
Host: hostname of the docker host
Login: user
SSH port: 50000
Session type: Single Application: Terminal

