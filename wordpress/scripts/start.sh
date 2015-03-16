#!/bin/bash

set -e

__handle_passwords() {
DB_NAME="${DB_ENV_NAME-$DB_NAME}"
if [ -z "$DB_ENV_NAME" ]; then
  printf <<EOF
No DB_ENV_NAME or DB_NAME variable. Please link to database using alias 'db'
or provide DB_NAME variable.
EOF
  exit 1
fi
if [ -z "$DB_ENV_USER" ]; then
  printf "No DB_ENV_USER variable. Please link to database using alias 'db'.\n"
  exit 1
fi
# Here we generate random passwords (thank you pwgen!) for random keys in wp-config.php
printf "Creating wp-config.php...\n"
# There used to be a huge ugly line of sed and cat and pipe and stuff below,
# but thanks to @djfiander's thing at https://gist.github.com/djfiander/6141138
# there isn't now.
sed -e "s/database_name_here/$DB_NAME/
s/username_here/$DB_ENV_USER/
s/password_here/$DB_ENV_PASS/
/'AUTH_KEY'/s/put your unique phrase here/`pwgen -s -1 65`/
/'SECURE_AUTH_KEY'/s/put your unique phrase here/`pwgen -s -1 65`/
/'LOGGED_IN_KEY'/s/put your unique phrase here/`pwgen -s -1 65`/
/'NONCE_KEY'/s/put your unique phrase here/`pwgen -s -1 65`/
/'AUTH_SALT'/s/put your unique phrase here/`pwgen -s -1 65`/
/'SECURE_AUTH_SALT'/s/put your unique phrase here/`pwgen -s -1 65`/
/'LOGGED_IN_SALT'/s/put your unique phrase here/`pwgen -s -1 65`/
/'NONCE_SALT'/s/put your unique phrase here/`pwgen -s -1 65`/" /var/www/html/wp-config-sample.php > /var/www/html/wp-config.php
}

__handle_db_host() {
# Update wp-config.php to point to our linked container's address.
sed -i -e "s/^\(define('DB_HOST', '\).*\(');.*\)/\1${DB_PORT#tcp://}\2/" \
  /var/www/html/wp-config.php
}

__httpd_perms() {
chown apache:apache /var/www/html/wp-config.php
}

__run_apache() {
exec /scripts/run-apache.sh
}

__check() {
if [ ! -f /var/www/html/wp-config.php ]; then
  __handle_passwords
  __httpd_perms
fi
__handle_db_host
}

# Call all functions
__check
__run_apache
