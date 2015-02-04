dockerfiles-fedora-wordpress
============================

(note: This originated from [jbfink](https://github.com/jbfink). It has been ported over to Fedora and made linkable with the mariadb container.)

Tested on Docker 1.4.1

(note: [Eugene Ware](http://github.com/eugeneware) has a Docker wordpress container build on nginx with some other goodies; you can check out his work [here](http://github.com/eugeneware/docker-wordpress-nginx).)

This repo contains a recipe for making a [Docker](http://docker.io) container for Wordpress, using Apache on Fedora, linked with a MariaDB/MySQL container. 
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone this repo somewhere, and then build both mariadb and wordpress images:

```
# cd mariadb
# docker build --rm -t <yourname>/mariadb .
```

```
# cd wordpress
# docker build --rm -t <yourname>/wordpress .
```

### Quick start ###

Run the mariadb container:

```
# docker run --name=mydb -e USER=wordpress -e PASS=$(pwgen -s -1) -e NAME=wordpress -d <yourname>/mariadb
```

Then run the wordpress container, using the alias 'db' for the linked MariaDB container:

```
# CID=$(docker run -p 80 --link=mydb:db -d <yourname>/wordpress)
```

Then find the external port assigned to your container:

```
# docker port $CID 80 
```

Visit in a webrowser, then fill out the form. No need to mess with wp-config.php, it's been auto-generated with proper values. 

### Using volumes ###

To make sure the wordpress data is persistent, you'll want to use separate data volumes for the MariaDB database and the wordpress content (media, themes, plugins etc).

For the database:

```
# docker run -e USER=wordpress -e PASS=$(pwgen -s -1) -e NAME=wordpress \
    -v /mnt/db:/var/lib/mysql -d <yourname>/mariadb
```

If /mnt/db has already been initialised, make sure to use the correct values for USER, PASS, and NAME, rather than creating new ones.

For the wordpress instance:

```
# docker run --link=the-mariadb-container:db -p 80 \
    -v /mnt/wp-content:/var/www/html/wp-content -d <yourname>/wordpress
```

The container will generate a new wp-config.php based on the information provided by the linked container. Local configuration changes to wp-config.php will not persist when making a new wordpress container even if you are using a volume for wp-content.

If you remove the linked mariadb container and create a new one, you will need to update the DB_HOST setting in wp-config.php, or simply create a new wordpress container linked to the new mariadb container.
