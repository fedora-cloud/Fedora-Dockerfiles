FROM fedora:23
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Updating dependencies
RUN dnf -y update

# Installing Apache
RUN dnf -y install httpd

# Cleaning dnf caches to reduce container size
RUN dnf clean all

# Creating placeholder file to be served by apache
RUN echo "Apache" >> /var/www/html/index.html

# We open 80 port, the default one for HTTP for Apache server to listen on
EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh

CMD ["/run-apache.sh"]
