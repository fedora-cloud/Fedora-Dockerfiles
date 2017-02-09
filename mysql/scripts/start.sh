#!/bin/bash

if [ -x /scripts/config_mysql.sh ]; then
  /scripts/config_mysql.sh
fi

rm -f /run/mysqld/mysqld.sock
exec /usr/bin/mysqld_safe
