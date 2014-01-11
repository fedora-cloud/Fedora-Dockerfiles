dockerfiles-fedora-MySQL
========================

Tested on Docker 0.7.2

This repo contains a recipe for making Docker container for SSH and MySQL on Fedora. 

\# docker build -rm -t <yourname>/MySQL .

Run it:

\# docker run -d -p 3306:3306 <yourname>/MySQL

Get container ID:

\# docker ps

Keep in mind the password set for MySQL is: mysqlPassword

Get the IP address for the container:

\# docker inspect <container_id> | grep -i ipaddr

For MySQL:
\# mysql -h 172.17.0.x -utestdb -pmysqlPassword
