dockerfiles-fedora-cups
========================

This is a recipe for making a Docker container CUPS on Fedora. It has
been tested with docker 1.2.0.

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build-

```
# docker build --rm -t <username>/cups .
```

### Running as default CUPS server

To run, mapping local port 631 to port 631 on the container:

```
# docker run -d -p 631:631 \
	-e CUPS_ADMIN_USER=user -e CUPS_ADMIN_PASSWORD=password \
	<username>/cups
```

To use connect to the CUPS server in the container, make sure the `cups.socket`, `cups.path`, and `cups.service` systemd units are not running and remove the UNIX domain socket created by the `cups.socket` unit:

```
# systemctl stop cups.socket cups.path cups.service
# rm /var/run/cups/cups.sock
```

Using CUPS from the command line is as usual:

```
# lpstat -t
# cupsctl -U {CUPS_ADMIN_USER}
etc...
```

View https://localhost:631/ for the web interface.

### Running in parallel with default CUPS server

You can also run CUPS in parallel in a container:

```
# docker run -d -p 631 \
	-e CUPS_ADMIN_USER=user -e CUPS_ADMIN_PASSWORD=password \
	<username>/cups
```

You need to know the local port number that maps to the container's
TCP port 631:

```
# docker ps
```

You can tell the CUPS command line tools which server to connect to
using the -h option:

```
$ lpstat -h localhost:49999 -s
```

or set the default server in ~/.cups/client.conf:

```
$ mkdir ~/.cups
$ echo ServerName localhost:49999 > ~/.cups/client.conf
$ lpstat -s
```

If you set client.conf up in this way, graphical applications will
also use the CUPS server in the container when printing.

### Automating printer setup

You can set up a printer through the web interface or by passing additional environment variables to docker (useful for automation):

```
# docker run -d \
    -e CUPS_PRINTER_NAME=<printer> \
    -e CUPS_PRINTER_DRIVER=<driver> \
    -e CUPS_PRINTER_CONNECTION=<uri> \
    <username>/cups
```

See the man page of `lpadmin` for a detailed description of each option.

* `CUPS_PRINTER_NAME` - The unique name for the new printer. Must not contain spaces. `lpadmin` `destination`.
* `CUPS_PRINTER_DRIVER` - The System V interface script or PPD file for the printer. `lpadmin` option `-m`. 
* `CUPS_PRINTER_CONNECTION` - The device-uri attribute for the printer. `lpadmin` option `-v`.

To setup a Zebra label printer with a static IP address you could do:

```
# docker run -d \
    -e CUPS_PRINTER_NAME=GX420t \
    -e CUPS_PRINTER_DRIVER=drv:///sample.drv/zebraep2.ppd \
    -e CUPS_PRINTER_CONNECTION=socket://192.168.1.42 \
    <username>/cups
```

### Volumes

The volumes defined by this container are:

- /var/spool/cups (the spool directory)
- /var/log/cups (for logs)
