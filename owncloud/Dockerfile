FROM       fedora:21
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Perform updates
RUN yum -y update && yum clean all

# Install owncloud owncloud-httpd owncloud-sqlite rpms
RUN yum install -y owncloud{,-httpd,-sqlite} && yum clean all

# Install SSL module and force SSL to be used by owncloud
RUN yum install -y mod_ssl && yum clean all
ADD ./forcessl.config.php /etc/owncloud/forcessl.config.php

# Allow connections from everywhere
RUN ln -s /etc/httpd/conf.d/owncloud-access.conf.avail /etc/httpd/conf.d/z-owncloud-access.conf

# Expose port 443 and set httpd as our entrypoint
EXPOSE 443
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]

