#!/bin/bash

sed -i \
        -e 's,"interfaces": \[ \],"interfaces": \[ "eth0" \],' \
        /etc/kea/kea.conf
