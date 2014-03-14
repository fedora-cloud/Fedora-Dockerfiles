dockerfiles-fedora-bind
========================

Fedora dockerfile for Bind - based resolving & cache'ing (DNS server)

Tested on Docker 0.8.0

Configuration
-----

You should configure legit networks in cfg_files/named.conf in order to allow
those to query this DNS server. By default legit networks are 127.0.0.1 and
whole 172.16.0.0/12 private network (as Docker uses those ranges for internal
networking).

Installation
-----

Clone Dockerfile somewhere and run:

    $ sudo docker build -t --rm .
    $ sudo docker run --rm -dns 127.0.0.1 -p 53:53/udp -p 53:53/tcp -name bind -t -d bind

Testing
-----

Just use tools like dig. First check the IP address assigned to container:

    $ sudo docker inspect -format '{{ .NetworkSettings.IPAddress }}' container_id

And next use use dig:

    $ dig google.com @container_IP_ADDR

Managing own zone files (domains)
-----

Just add zones definitions to named.conf, create zone files and use Docker ADD command top copy those to the container
