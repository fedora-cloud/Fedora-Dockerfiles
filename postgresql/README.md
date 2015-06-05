dockerfiles-fedora-postgresql
=============================

Fedora dockerfile for PostgreSQL

1. To build

    Copy the sources down and do the build:

    `# docker build --rm -t username/postgresql . |& tee postgres_build.log`

2. To get help output

    `# docker run username/postgresql container-usage`

3. To run

    If port 5432 is open on your host:

    ```
    # mkdir data
    # chown 26:26 data
    # chcon -t svirt_sandbox_file_t data
    # docker run -v "`pwd`/data:/var/lib/pgsql/data" -d -p 5432:5432 username/postgresql
    ```

    or to assign a random port that maps to port 5432 on the container:

    ``# docker run -v "`pwd`/data:/var/lib/pgsql/data" -d -p 5432 username/postgresql``

    To see the random port that the container is listening on:

    `# docker ps`

4. To test

    To find the IP address, get the container ID:

    `# docker ps`

    Then get the IP addr:

    `# docker inspect --format '{{ .NetworkSettings.IPAddress }}' a0d14cc9830B`

    Now connect to the instance of PostgreSQL.  There is no default database at this
    time, neither the "default" password for 'postgres' (admin) user.  Please look
    at the 'container-usage' output described above how to setup that.

    ```
    # psql -h 172.17.0.x -U postgres
    Password for user postgres:
    ```
