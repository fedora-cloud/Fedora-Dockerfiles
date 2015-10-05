dockerfiles-fedora-kea
=========================

Fedora dockerfile for kea - DHCPv4, DHCPv6 and Dynamic DNS servers.
Tested on Docker 1.8.2

Clone Dockerfile somewhere and build the container:

    # docker build --rm -t <username>/kea .

Create a volume containers for configuration file and leases database:

    # docker run -d -v /etc/kea --name kea-conf <username>/kea true
    # docker run -d -v /var/lib/kea --name kea-db <username>/kea true

Use a temporary container to edit the ``/etc/kea/kea.conf``:

    # docker run --rm -it --volumes-from kea-conf <username>/kea vi /etc/kea/kea.conf

Run named container (for DHCPv4):

    # docker run -d -p 67:67/udp --volumes-from kea-conf --volumes-from kea-db --name kea4 <username>/kea

Or DHCPv6:

    # docker run -d -p 547:547/udp --volumes-from kea-conf --volumes-from kea-db --name kea6 <username>/kea dhcp6

Or DHCP-DDNS:

    # docker run -d --volumes-from kea-conf --name kea-ddns <username>/kea ddns
