
dockerfiles-fedora-qpidd
========================

Fedora dockerfile for Apache Qpid

Get Docker version

    # docker version

To build:

    # docker build --rm -t fedora-qpidd .

Launch the container using:

    # docker run -p 5672 fedora-qpidd

Check what port is mapped to 5672 

    # docker ps

e.g. 2a16c0dda3b8 4e431243448a qpidd -t --auth=no 19 seconds ago Up 18 seconds 0.0.0.0:49153->5672/tcp

You can install qpid-tools package on the host and run the following to test:

    # qpid-tool localhost:49153

Where 49153 is the port that was revealed in the docker ps above.
