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
	CREATE DATABASE $NAME;
	CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
	GRANT ALL PRIVILEGES ON $NAME.* TO '$USER'@'%' WITH GRANT OPTION;
EOF

  killall mysqld
  sleep 10
}

# Call all functions
__mysql_config
__start_mysql

