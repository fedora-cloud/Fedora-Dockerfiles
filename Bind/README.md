dockerfiles-fedora-bind
========================

Fedora dockerfile for Bind - based resolving & cache'ing (DNS server)

Tested on Docker 0.8.0

Installation
-----

Clone Dockerfile somewhere and run:

    $ sudo docker build -t --rm .
    $ sudo docker run --rm -dns 127.0.0.1 -p 53:53/udp -p 53:53/tcp -name bind -t -d bind

Managing own zone files (domains)
-----

Just add zones definitions to named.conf, create zone files and use Docker ADD command top copy those to the container
