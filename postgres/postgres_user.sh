#!/bin/bash

__mod_user() {
usermod -G wheel postgres
}

__create_db() {
su --login postgres --command "createuser dockeruser"
su --login postgres --command "createdb dockerdb"
su --login postgres --command "psql -c 'GRANT ALL PRIVILEGES ON DATABASE dockerdb to dockeruser';"
}


__mod_user
__create_db
