#!/bin/bash

set -e

# Show settings first, so they aren't buried in the noise.
USER="${USER-dbuser}"
PASS="${PASS-$(pwgen -s -1 12)}"
NAME="${NAME-db}"
printf "\n"
printf "root password=\n"
printf "NAME=%s\n" "$NAME"
printf "USER=%s\n" "$USER"
printf "PASS=%s\n" "$PASS"
printf "\n"

echo "Initializing mariadb"
mysql_install_db --user=mysql

echo "Starting mysqld for initial configuration"
/usr/libexec/mysqld &
PID=$!

for i in {30..0}; do
  if (! kill -0 $PID) ||
     (echo 'SELECT 1' | mysql -u root >/dev/null 2>&1)
  then
    break
  fi
  sleep 1
done

if ! kill -0 $PID; then
  echo
  echo "mysqld failed to start"
  exit 1
fi

if ! (echo 'SELECT 1' | mysql -u root >/dev/null 2>&1); then
  echo
  echo "Timeout waiting for mysqld to become ready"
  exit 1
fi

mysql -uroot <<-EOF
CREATE DATABASE $NAME;
CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $NAME.* TO '$USER'@'%' WITH GRANT OPTION;
EOF

kill $PID
wait $PID
