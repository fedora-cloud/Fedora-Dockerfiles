# Based on the Fedora image
FROM fedora

# File Author / Maintainer
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Install Squid
RUN yum -y update; yum clean all;
RUN yum -y install squid; yum clean all;
RUN yum -y install httpd-tools; yum clean all;

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
