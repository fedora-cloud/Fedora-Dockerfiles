dockerfiles-fedora-dhcpd
=========================

Fedora dockerfile for dhcpd - DHCP server.
Tested on Docker 1.2.0

Clone Dockerfile somewhere and build the container:

```
# docker build --rm -t <username>/dhcpd .
```

Create a volume container for the /data:

```bash
# docker run -d -v /data --name dhcpd-data fedora true
```

Run the container:

```bash
# docker run -d --volumes-from dhcpd-data --name dhcpd <username>/dhcpd
```

Use a temporary container to edit the ``/data/dhcpd.conf``:

```bash
# docker run -i -t --volumes-from dhcpd-data fedora /bin/sh -l
```

Edit ``/data/dhcpd.conf`` as desired, then restart the dhcpd container.

```bash
# docker restart dhcpd
```
