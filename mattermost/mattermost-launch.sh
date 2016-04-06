#!/bin/bash -x

# Backup default config.json file at first boot
if [ ! -f /opt/mattermost/config/config.json.orig ]; then
  cp -a /opt/mattermost/config/config.json /opt/mattermost/config/config.json.orig
fi

if [ "$DRIVER_NAME" = "mysql" ]; then
    sed -e 's#"DriverName": "mysql"#"DriverName": "'"$DRIVER_NAME"'"#' \
        -e 's#"DataSource": "mmuser:mostest@tcp(mysql:3306)/mattermost_test?charset=utf8mb4,utf8"#"DataSource": "'"$MYSQL_USER:$MYSQL_PASSWORD@tcp($(printenv ${DATABASE_SERVICE_NAME^^}_SERVICE_HOST):$(printenv ${DATABASE_SERVICE_NAME^^}_SERVICE_PORT))/$MYSQL_DATABASE?charset=utf8mb4,utf8"'"#' \
        /opt/mattermost/config/config.json.orig > /opt/mattermost/config/config.json
fi

exec /opt/mattermost/bin/platform
