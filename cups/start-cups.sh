#!/bin/bash
if ! grep -q "^$CUPS_ADMIN_USER:" /etc/shadow; then
	echo Adding "$CUPS_ADMIN_USER" user
	useradd "$CUPS_ADMIN_USER" --system -G root,sys -M
	printf "%s\n%s\n" "$CUPS_ADMIN_PASSWORD" "$CUPS_ADMIN_PASSWORD" | \
		(passwd --stdin "$CUPS_ADMIN_USER")
	echo Done
fi

exec /usr/sbin/cupsd -f
