#!/bin/bash
if [ -z "$CUPS_ADMIN_USER" ]; then
	printf "No CUPS_ADMIN_USER environment variable set.\n"
	exit 1
fi

if ! grep -q "^$CUPS_ADMIN_USER:" /etc/shadow; then
	echo Adding "$CUPS_ADMIN_USER" user
	useradd "$CUPS_ADMIN_USER" --system -G root,sys -M
	printf "%s\n%s\n" "$CUPS_ADMIN_PASSWORD" "$CUPS_ADMIN_PASSWORD" | \
		(passwd --stdin "$CUPS_ADMIN_USER")
fi

if [ -n "$CUPS_PRINTER_NAME" ]; then
	/usr/sbin/cupsd

	echo Adding printer $CUPS_PRINTER_NAME:
	echo "  Driver: $CUPS_PRINTER_DRIVER"
	echo "  Connection: $CUPS_PRINTER_CONNECTION"
	lpadmin -p $CUPS_PRINTER_NAME -E -m $CUPS_PRINTER_DRIVER -v $CUPS_PRINTER_CONNECTION

	kill $(ps -eo comm,pid | grep cupsd | awk '{ print $2 }')
fi

exec /usr/sbin/cupsd -f
