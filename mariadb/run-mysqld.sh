#!/bin/bash

source $HOME/common.sh
set -eu

mysql_flags="-u root --socket=/tmp/mysql.sock"
admin_flags="--defaults-file=$MYSQL_DEFAULTS_FILE $mysql_flags"

cmd="$1"; shift

if [ "${cmd}" == "mysqld-master" ] &&  [ ! -d "${MYSQL_DATADIR}/mysql" ]; then
  exec /usr/local/bin/run-mysqld-master.sh "$@"
fi

if [ "${cmd}" == "mysqld-slave" ] &&  [ ! -d "${MYSQL_DATADIR}/mysql" ]; then
  exec /usr/local/bin/run-mysqld-slave.sh "$@"
fi

if [ "${cmd}" == "mysqld" ]; then
  validate_variables
  envsubst < ${MYSQL_DEFAULTS_FILE}.template > $MYSQL_DEFAULTS_FILE

  if [ ! -d "$MYSQL_DATADIR/mysql" ]; then
    initialize_database "$@"
  else
    start_local_mysql "$@"
  fi

# Set the password for MySQL user and root everytime this container is started.
# This allows to change the password by editing the deployment configuration.
if [[ -v MYSQL_USER && -v MYSQL_PASSWORD ]]; then
  mysql $mysql_flags <<EOSQL
    SET PASSWORD FOR '${MYSQL_USER}'@'%' = PASSWORD('${MYSQL_PASSWORD}');
EOSQL
fi

# The MYSQL_ROOT_PASSWORD is optional, therefore we need to either enable remote
# access with a password if the variable is set or disable remote access otherwise.
if [ -v MYSQL_ROOT_PASSWORD ]; then
  # GRANT will create a user if it doesn't exist and set its password
  mysql $mysql_flags <<EOSQL
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
EOSQL
else
  # We do GRANT and DROP USER to emulate a DROP USER IF EXISTS statement
  # http://bugs.mysql.com/bug.php?id=19166
  mysql $mysql_flags <<EOSQL
    GRANT USAGE ON *.* TO 'root'@'%';
    DROP USER 'root'@'%';
    FLUSH PRIVILEGES;
EOSQL
fi

  mysqladmin $admin_flags flush-privileges shutdown

  unset_env_vars
  exec /usr/libexec/mysqld --defaults-file=$MYSQL_DEFAULTS_FILE "$@" 2>&1
fi

unset_env_vars
exec $cmd "$@"
