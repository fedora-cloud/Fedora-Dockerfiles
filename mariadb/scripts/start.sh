#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
  echo "Initializing empty /var/lib/mysql..."
  /scripts/config_mariadb.sh || exit 1
fi

rm -f /run/mysqld/mysqld.sock
exec /usr/bin/mysqld_safe -u mysql
