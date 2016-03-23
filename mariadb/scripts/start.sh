#!/bin/bash

if [ ! -d /var/lib/mysql/mysql ]; then
  echo "Initializing empty /var/lib/mysql..."
  /scripts/config_mariadb.sh || exit 1
  echo "/var/lib/mysql initialized. Ready to start"
fi

rm -f /run/mysqld/mysqld.sock
exec /usr/libexec/mysqld
