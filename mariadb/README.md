dockerfiles-fedora-mariadb
==========================

Based on scollier's mysql dockerfile.

This repo contains a recipe for making a Docker container for mariadb
on Fedora.

Setup
-----

Check your Docker version

    # docker version

Perform the build

    # docker build --rm -t <yourname>/mariadb .

Check the image out.

    # docker images

Launching MariaDB
-----------------

### Stand-alone database: ###

    # docker run --name=mariadb -d -p 3306:3306 <yourname>/mariadb

This will create the system tables and a database named 'db', with user 'dbuser' and a generated password. To find out what the password is, check the logs:

    # docker logs mariadb | grep -E '^USER|^PASS'

### Adjustable configuration ###

Create a data volume container:

    # docker run --name=mariadb-data -v /var/lib/mysql \
        --entrypoint /bin/echo <yourname>/mariadb "MariaDB data volume"

Now create the persistent container, using the data volume container for storage:

    # docker run --name=mariadb --volumes-from=mariadb-data \
        -p 3306:3306 -d <yourname>/mariadb

The container will not re-initialise an already-initialised data volume.

Using your MariaDB container
----------------------------

Connecting to mariadb:

    # mysql --protocol=tcp db -udbuser -p

Use the password indicated in the 'docker logs' output.

Create a sample table:

    \> CREATE TABLE test (name VARCHAR(10), owner VARCHAR(10),
        -> species VARCHAR(10), birth DATE, death DATE);

Linking with another container
------------------------------

To arrange for linking with another container, set the USER, PASS, and NAME environment variables when creating the mariadb container. You don't need to expose any ports, as they are available to other containers automatically:

    # docker run --name=mariadb --volumes-from=mariadb-data \
        -e USER=user -e PASS=mypassword -e NAME=mydb \
	-d <yourname>/mariadb

This will create a database named 'mydb', and a user 'user' with the specified password. To link another container to this one, use the --link option to 'docker run':

    # docker run --link=mariadb:db -d <yourname>/mydbapp

As we've set the alias for the linked mariadb container to 'db', the 'mydbapp' container will have environment variables set to give it the information it needs:

  - DB_PORT will specify the protocol, host, and port
  - DB_ENV_NAME will be 'mydb'
  - DB_ENV_USER will be 'user'
  - DB_ENV_PASS will be 'mypassword'

Using mariadb as a client to an existing mariadb container
----------------------------------------------------------

To run a query against an existing container, using the client from this container image, create a new container linked to the existing one:

    # docker run --rm --link=mariadb:db -i -t <yourname>/mariadb sh -c 'mysql -h $DB_PORT_3306_TCP_ADDR -P $DB_PORT_3306_TCP_PORT -u$DB_ENV_USER -p$DB_ENV_PASS'
