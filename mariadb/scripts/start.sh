#!/bin/bash

if [ -x /scripts/config_mariadb.sh ]; then
  # Initial configuration
  /scripts/config_mariadb.sh || exit 1
fi

rm -f /run/mysqld/mysqld.sock
exec /usr/bin/mysqld_safe
