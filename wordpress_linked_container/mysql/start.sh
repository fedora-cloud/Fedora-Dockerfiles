#!/bin/bash

__create_user() {
# Create a user to SSH into as.
SSH_USERPASS=`pwgen -c -n -1 8`
useradd -G wheel user
echo user:$SSH_USERPASS | chpasswd
echo ssh user password: $SSH_USERPASS
}

__mysql_config() {
# Hack to get MySQL up and running... I need to look into it more.
yum -y erase community-mysql community-mysql-server
rm -rf /var/lib/mysql/ /etc/my.cnf
yum -y install community-mysql community-mysql-server
mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe & 
sleep 10
}

__handle_passwords() {
# Here we generate random passwords (thank you pwgen!). The first two are for mysql users, the last batch for random keys in wp-config.php
WORDPRESS_DB="wordpress"
MYSQL_PASSWORD=`pwgen -c -n -1 12`
WORDPRESS_PASSWORD=`pwgen -c -n -1 12`
# This is so the passwords show up in logs. 
echo mysql root password: $MYSQL_PASSWORD
echo wordpress password: $WORDPRESS_PASSWORD
echo $MYSQL_PASSWORD > /mysql-root-pw.txt
echo $WORDPRESS_PASSWORD > /wordpress-db-pw.txt
}

__start_mysql() {
# systemctl start mysqld.service
mysqladmin -u root password $MYSQL_PASSWORD 
mysql -uroot -p$MYSQL_PASSWORD -e "CREATE DATABASE wordpress; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY '$WORDPRESS_PASSWORD'; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'wordpress'@'%' IDENTIFIED BY '$WORDPRESS_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$WORDPRESS_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_PASSWORD -e "select user, host FROM mysql.user;"
killall mysqld
sleep 10
}

__run_supervisor() {
supervisord -n
}

# Call all functions
__create_user
__mysql_config
__handle_passwords
__start_mysql
__run_supervisor
