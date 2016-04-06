# Mattermost

This is a mattermost docker container images, it is reused by https://github.com/goern/mattermost-openshift

The license applies to all files inside this repository, not mattermost itself.

## Prerequisites

Docker on Fedora 23 or later, a little bit of disk space.

The matterost container will look for a MySQL database provided at the hostname `mysql`,
so you need to link to a mysql when running mattermost.

## Installation

### Configuration

Review the file `config.json` carefully and adopt it to your needs, it will be
put inside of the container image.

### Building

Just a simple `docker build --rm --tag <username>/mattermost .` will do it.

## Running

Start a MySQL container first, mattermost will need it: `docker run -ti --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=true -e MYSQL_USER=mmuser -e MYSQL_PASSWORD=mostest -e MYSQL_DATABASE=mattermost_test mariadb` This will use a mariadb from hub.docker.io. user, password and database must
match what you put in `config.json`.

Now run the mattermost container itself and link it to the mysql container: `docker run --detach --publish 8065:8065 --link db:mysql --name mattermost <username>/mattermost`

## Usage

Point your browser at `localhost:8065`, the first user you create will
be an Administrator of mattermost.
