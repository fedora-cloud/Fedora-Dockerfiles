dockerfiles-fedora-dhcpd
=========================

Fedora dockerfile for dhcpd - DHCP server.
Tested on Docker 1.3.0

Clone Dockerfile somewhere and build the container:

    # docker build --rm -t <username>/dhcpd .

Create a volume containers for configuration file and leases database:

    # docker run -d -v /etc/dhcp --name dhcpd-conf fedora true
    # docker run -d -v /var/lib/dhcpd --name dhcpd-db fedora true

Run dhcpd container. This creates default ``/etc/dhcp/dhcpd.conf``
with subnet declaration according to eth0's address:

    # docker run -d -p 67:67/udp --volumes-from dhcpd-conf --volumes-from dhcpd-db --name dhcpd <username>/dhcpd

Use a temporary container to edit the ``/etc/dhcp/dhcpd.conf``:

    # docker run -i -t --volumes-from dhcpd-conf fedora vi /etc/dhcp/dhcpd.conf

Edit ``/etc/dhcp/dhcpd.conf`` as desired, then restart the dhcpd container.

    # docker restart dhcpd
