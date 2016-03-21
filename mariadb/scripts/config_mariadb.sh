#!/bin/bash

set -e

__mysql_config() {
  echo "Running the mysql_config function."
  mysql_install_db --user=mysql
  /usr/bin/mysqld_safe -u mysql &
  sleep 10
}

__start_mysql() {
  printf "Running the start_mysql function.\n"
  USER="${USER-dbuser}"
  PASS="${PASS-$(pwgen -s -1 12)}"
  NAME="${NAME-db}"
  printf "root password=\n"
  printf "NAME=%s\n" "$NAME"
  printf "USER=%s\n" "$USER"
  printf "PASS=%s\n" "$PASS"
  mysql -uroot <<-EOF
	CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
	GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;
	CREATE DATABASE $NAME;
EOF

  killall mysqld
  sleep 10
}

# Call all functions
if [ ! -d /var/lib/mysql/mysql ]; then
  printf "Initializing empty /var/lib/mysql...\n"
  __mysql_config
  __start_mysql
fi

# Don't run this again.
rm -f /scripts/config_mariadb.sh
