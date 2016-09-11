# Clone from the Fedora image
FROM fedora

MAINTAINER Jan Pazdziora

# Install FreeIPA client and realmd
RUN mkdir -p /run/lock ; dnf install -y freeipa-client realmd /etc/selinux/targeted/contexts/dbus_contexts oddjob oddjob-mkhomedir sssd sssd-dbus adcli perl perl-Time-HiRes tar findutils && dnf clean all
RUN rm -f /usr/bin/sss_ssh_authorizedkeys
COPY dbus.service /etc/systemd/system/dbus.service
COPY oddjobd.service /etc/systemd/system/oddjobd.service

COPY systemctl-socket-daemon /usr/bin/systemctl-socket-daemon
COPY systemctl /usr/bin/systemctl

COPY host-data-list /etc/host-data-list
COPY install.sh run.sh uninstall.sh /bin/
RUN chmod +x /usr/bin/systemctl /usr/bin/systemctl-socket-daemon /bin/install.sh /bin/run.sh /bin/uninstall.sh

COPY rhel-domainname.service /etc/systemd/system/
COPY rhel-domainname.service /etc/systemd/system/fedora-domainname.service
COPY sssd.service /etc/sssd.service.template

LABEL INSTALL 'docker run --rm=true --privileged --net=host -v /:/host -e NAME=${NAME} -e IMAGE=${IMAGE} -e HOST=/host ${IMAGE} /bin/install.sh'
LABEL RUN 'docker run -d --restart=always --privileged --net=host --name ${NAME} -e NAME=${NAME} -e IMAGE=${IMAGE} \
	-v /etc/ipa/:/etc/ipa/:ro \
	-v /etc/krb5.conf:/etc/krb5.conf:ro \
	-v /etc/krb5.keytab:/etc/krb5.keytab:ro \
	-v /etc/nsswitch.conf:/etc/nsswitch.conf:ro \
	-v /etc/openldap/:/etc/openldap/:ro \
	-v /etc/pam.d/:/etc/pam.d/:ro \
	-v /etc/passwd:/etc/passwd.host:ro \
	-v /etc/pki/nssdb/:/etc/pki/nssdb/:ro \
	-v /etc/ssh/:/etc/ssh/:ro \
	-v /etc/sssd/:/etc/sssd/:ro \
	-v /etc/systemd/system/sssd.service.d:/etc/systemd/system/sssd.service.d:ro \
	-v /etc/sysconfig/authconfig:/etc/sysconfig/authconfig:ro \
	-v /etc/sysconfig/network:/etc/sysconfig/network:ro \
	-v /etc/sysconfig/sssd:/etc/sysconfig/sssd:ro \
	-v /etc/yp.conf:/etc/yp.conf:ro \
	-v /var/cache/realmd/:/var/cache/realmd/ \
	-v /var/lib/authconfig/last/:/var/lib/authconfig/last/:ro \
	-v /var/lib/ipa-client/sysrestore/:/var/lib/ipa-client/sysrestore/:ro \
	-v /var/lib/samba/:/var/lib/samba/ \
	-v /var/lib/sss/:/var/lib/sss/ \
	-v /var/log/sssd/:/var/log/sssd/ \
	-v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
	${IMAGE} /bin/run.sh'
LABEL UNINSTALL 'docker run --rm=true --privileged --net=host -v /:/host -e NAME=${NAME} -e IMAGE=${IMAGE} -e HOST=/host ${IMAGE} /bin/uninstall.sh'
LABEL STOP 'docker kill -s TERM ${NAME}'
