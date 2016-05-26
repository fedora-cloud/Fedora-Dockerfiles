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
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;
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

