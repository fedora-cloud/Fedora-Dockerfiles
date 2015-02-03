#!/bin/bash

set -e

__mysql_config() {
  echo "Running the mysql_config function."
  mysql_install_db
  chown -R mysql:mysql /var/lib/mysql
  /usr/bin/mysqld_safe &
  sleep 10
}

__start_mysql() {
  printf "Running the start_mysql function.\n"
  ROOT_PASS="$(pwgen -s -1 12)"
  USER="${USER-dbuser}"
  PASS="${PASS-$(pwgen -s -1 12)}"
  NAME="${NAME-db}"
  printf "root password=%s\n" "$ROOT_PASS"
  printf "NAME=%s\n" "$NAME"
  printf "USER=%s\n" "$USER"
  printf "PASS=%s\n" "$PASS"
  mysqladmin -u root password "$ROOT_PASS"
  mysql -uroot -p"$ROOT_PASS" <<-EOF
	DELETE FROM mysql.user WHERE user = '$USER';
	FLUSH PRIVILEGES;
	CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASS';
	GRANT ALL PRIVILEGES ON *.* TO '$USER'@'localhost' WITH GRANT OPTION;
	CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
	GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;
	CREATE DATABASE $NAME;
EOF

  killall mysqld
  sleep 10
}

# Call all functions
DB_FILES=$(echo /var/lib/mysql/*)
DB_FILES="${DB_FILES#/var/lib/mysql/\*}"
DB_FILES="${DB_FILES#/var/lib/mysql/lost+found}"
if [ -z "$DB_FILES" ]; then
  printf "Initializing empty /var/lib/mysql...\n"
  __mysql_config
  __start_mysql
fi

# Don't run this again.
rm -f /scripts/config_mariadb.sh
