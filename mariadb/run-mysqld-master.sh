#!/bin/bash
#
# This is an entrypoint that runs the MySQL server in the 'master' mode.
#
source ${HOME}/common.sh
set -eu

mysql_flags="-u root --socket=/tmp/mysql.sock"
admin_flags="--defaults-file=$MYSQL_DEFAULTS_FILE $mysql_flags"

validate_replication_variables
validate_variables

# Generate the unique 'server-id' for this master
export MYSQL_SERVER_ID=$(server_id)
echo "The 'master' server-id is ${MYSQL_SERVER_ID}"

# Process the MySQL configuration files
envsubst < $HOME/my.cnf.template > $HOME/my-common.cnf
envsubst < $HOME/my-master.cnf.template > $MYSQL_DEFAULTS_FILE

# Initialize MySQL database if this is the first time this containr runs and there
# are no existing data. In other case just start the local mysql to allow editing
# configuration
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

# Setup the 'master' replication on the MySQL server
mysql $mysql_flags <<EOSQL
  GRANT REPLICATION SLAVE ON *.* TO '${MYSQL_MASTER_USER}'@'%' IDENTIFIED BY '${MYSQL_MASTER_PASSWORD}';
  FLUSH PRIVILEGES;
EOSQL

# Restart the MySQL server with public IP bindings
mysqladmin $admin_flags flush-privileges shutdown
unset_env_vars
exec /usr/libexec/mysqld --defaults-file=$MYSQL_DEFAULTS_FILE "$@" 2>&1
