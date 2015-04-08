# Based on the Fedora image
FROM fedora

MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all

# Package with dhcpd is called dhcp up to f21 and dhcp-server since f22.
# We try to install both dhcp and dhcp-server packages, so it works with all
# Fedora releases. If one of the packages doesn't exist (for example
# dhcp-server on F21) yum tells you that 'No package dhcp-server available.',
# but still installs the other one and everything's OK.
# Even on F22 dhcp-compat provides dhcp, this will possibly be removed
# in future, so we explicitly install also dhcp-server package.
# ip & ipcalc are needed in dhcpd.sh
RUN yum -y install dhcp dhcp-server /usr/sbin/ip /usr/bin/ipcalc && yum clean all

ADD dhcpd.sh /dhcpd

EXPOSE 67/udp
EXPOSE 547/udp
EXPOSE 647/udp
EXPOSE 847/udp

ENTRYPOINT ["/dhcpd"]
CMD ["-d", "-cf", "/etc/dhcp/dhcpd.conf", "-lf", "/var/lib/dhcpd/dhcpd.leases", "--no-pid"]
