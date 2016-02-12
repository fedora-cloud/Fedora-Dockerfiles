# Based on the Fedora image
FROM fedora

MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf clean all

RUN dnf -y install dhcp-server /usr/sbin/ip /usr/bin/ipcalc && dnf clean all

ADD dhcpd.sh /dhcpd

EXPOSE 67/udp
EXPOSE 547/udp
EXPOSE 647/udp
EXPOSE 847/udp

ENTRYPOINT ["/dhcpd"]
CMD ["-d", "-cf", "/etc/dhcp/dhcpd.conf", "-lf", "/var/lib/dhcpd/dhcpd.leases", "--no-pid"]
