#/bin/bash

# create named.conf template - we'll use it later
mv /etc/named.conf /etc/named.conf.orig
ln -s /etc/named/named.conf  /etc/named.conf

if [ ! -d /var/log/named ]; then
    mkdir /var/log/named
fi

# let's make sure that external mount for named logs has correct owner:
chown named:named /var/log/named
