Tested on Docker 1.8.2

Run dhclient in a container and verify that it doesn't get any response for now:

    # docker run --rm -it fedora sh -c 'dnf -y install dhcp-client && dhclient -d eth0'
    DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval x
    DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval xx
    DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval xx
    etc.

press Ctrl+c

Build the kea image if you haven't already:

    # docker build --rm -t <username>/kea .

Create a volume containers for configuration file and leases database:

    # docker run -d -v /etc/kea --name kea-conf <username>/kea true
    # docker run -d -v /var/lib/kea --name kea-db <username>/kea true

Use a temporary container to edit the ``/etc/kea/kea.conf``:

    # docker run --rm -it --volumes-from kea-conf <username>/kea vi /etc/kea/kea.conf

change

    "subnet4": [
    #  {    "subnet": "192.0.2.0/24",
    #       "pools": [ { "pool": "192.0.2.1 - 192.0.2.200" } ] }
    ]

to

    "subnet4": [
    {    "subnet": "172.17.0.0/16",
         "pools": [ { "pool": "172.17.0.100 - 172.17.0.200" } ] }
    ]

Where 172.17.0.0/16 should be the subnet the containers' interfaces are in.
You can verify it with

    # docker run --rm -it fedora sh -c 'dnf -y install iproute; ip -4 addr show eth0'

Run kea (DHCPv4) in named container:

    # docker run -d -p 67:67/udp --volumes-from kea-conf --volumes-from kea-db --name kea4 <username>/kea

If you see error ... listen udp 0.0.0.0:67: bind: address already in use
you have to kill dnsmasq (which has been run by libvirtd) and run the container again.

    # killall dnsmasq

Try the dhclient once more and you should see something like:

    # docker run --rm -it fedora sh -c 'dnf -y install dhcp-client && dhclient -d eth0'
    DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 4
    DHCPREQUEST on eth0 to 255.255.255.255 port 67
    DHCPOFFER from 172.17.0.xx
    DHCPACK from 172.17.0.xx
    bound to 172.17.0.100 -- renewal in x seconds.

If you killed dnsmasq previously, you can restart libvirtd, which will spawn it.

    # systemctl restart libvirtd
