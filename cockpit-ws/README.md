dockerfiles-fedora-cockpit-ws
=============================

Docker build file for a privileged container containing cockpit-ws.

This is to be used on an Atomic host that already contains the
cockpit-bridge and cockpit-shell packages included.

To run this priviled container use the 'atomic' command:

    $ sudo atomic run <username>/cockpit-ws

This container listens on the Cockpit port 9090. This is a privileged
container, and does not work with port mappings.

To build this container use the following command:

    $ sudo docker build --rm -t <username>/cockpit-ws .

Upstream for the Docker file is in the 'tools' directory at:

https://github.com/cockpit-project/cockpit
