#!/bin/bash
#
# This is an entrypoint that runs the MySQL server in the 'slave' mode.
#
source ${HOME}/common.sh
set -eu

export MYSQL_RUNNING_AS_SLAVE=1

mysql_flags="-u root --socket=/tmp/mysql.sock"
admin_flags="--defaults-file=$MYSQL_DEFAULTS_FILE $mysql_flags"

validate_replication_variables

# Generate the unique 'server-id' for this master
export MYSQL_SERVER_ID=$(server_id)
echo "The 'slave' server-id is ${MYSQL_SERVER_ID}"

# Process the MySQL configuration files
envsubst < $HOME/my.cnf.template > $HOME/my-common.cnf
envsubst < $HOME/my-slave.cnf.template > $MYSQL_DEFAULTS_FILE

# Initialize MySQL database and wait for the MySQL master to accept
# connections.
initialize_database "$@"
wait_for_mysql_master

mysql $mysql_flags <<EOSQL
  CHANGE MASTER TO MASTER_HOST='${MYSQL_MASTER_SERVICE_NAME}',MASTER_USER='${MYSQL_MASTER_USER}', MASTER_PASSWORD='${MYSQL_MASTER_PASSWORD}';
EOSQL

# Restart the MySQL server with public IP bindings
mysqladmin $admin_flags flush-privileges shutdown
unset_env_vars
exec /usr/libexec/mysqld --defaults-file=$MYSQL_DEFAULTS_FILE \
  --report-host=$(hostname -i) "$@" 2>&1
