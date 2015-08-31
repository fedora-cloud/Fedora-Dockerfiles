FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN dnf -y update && dnf -y install kea iproute && dnf clean all
COPY adjust-config.sh start-kea.sh /usr/sbin/
RUN chmod -v +x /usr/sbin/adjust-config.sh /usr/sbin/start-kea.sh
RUN /usr/sbin/adjust-config.sh

# dhcp4
EXPOSE 67/udp
# dhcp6
EXPOSE 547/udp

ENTRYPOINT ["/usr/sbin/start-kea.sh"]

# run dhcpv4 server by default
# options are:
# dhcp4: dhcpv4 server
# dhcp6: dhcpv6 server
# ddns: dhcp-ddns server
# <others>: run arbitrary command (with args), like e.g. 'ls -la /var/lib/kea'
CMD ["dhcp4"]
