# Mattermost 3.0.1

This is a Mattermost 3.0.1 docker container images. As the Mattermost community
only provides a dev version and releases, but no link to the latest release, we
will use a specific version of Mattermost for this docker container image. Please
check [Mattermost release page](http://www.mattermost.org/download/) if updates
are available and send a pull request to this repository ;) Thanks!

This container image is reused by https://github.com/goern/mattermost-openshift

The license applies to all files inside this repository, not Mattermost itself.

## Prerequisites

Docker on Fedora 23 or later, a little bit of disk space.

The Matterost container will look for a MySQL 5.6+ database provided at the hostname `mysql`,
so you need to link to a mysql when running Mattermost.

## Installation

### Configuration

Review the file `config.json` carefully and adopt it to your needs. It will be
put inside of the container image, and holds especially the MySQL settings used
to start the Mattermost container.

### Building

Just a simple `docker build --rm --tag <username>/mattermost:3.0.1 .` will do it.

## Running

Start a MySQL container first, mattermost will need it: `docker run -ti --name db -e MYSQL_ALLOW_EMPTY_PASSWORD=true -e MYSQL_USER=mmuser -e MYSQL_PASSWORD=mostest -e MYSQL_DATABASE=mattermost_test mariadb` This will use a mariadb from hub.docker.io. user, password and database must
match what you put in `config.json`.

Now run the Mattermost container itself and link it to the mysql container: `docker run --detach --publish 8065:8065 --link db:mysql --name mattermost <username>/mattermost:3.0.1`

## Usage

Point your browser at `localhost:8065`, the first user you create will
be an Administrator of Mattermost.
