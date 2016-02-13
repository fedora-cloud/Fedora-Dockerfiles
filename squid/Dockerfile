# Based on the Fedora image
FROM fedora

# File Author / Maintainer
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Install Squid
RUN dnf -y update && dnf clean all
RUN dnf -y install squid && dnf clean all
RUN dnf -y install httpd-tools && dnf clean all

# Change the first occurrence squid.conf to auth_squid.conf
# if you would like to use authentication
ADD squid.conf /etc/squid/squid.conf
 
RUN squid -z -F
RUN htpasswd -b -c /etc/squid/passwd user1 password

# Expose ports
EXPOSE 3128

# Set the default command to execute
# when creating a new container
CMD squid -N -d 1
