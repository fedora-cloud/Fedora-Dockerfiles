#!/bin/bash

# Listen for network connections
sed -i \
	-e "0,/^Listen /{s,^Listen .*$,Port 631,}" \
	-e "/^Listen /d" \
	/etc/cups/cupsd.conf

# Allow remote connections
sed -i \
	-e "/<Location \/>/,/<\/Location>/{/<\/Location>/i\ \ Allow @LOCAL
}" \
	/etc/cups/cupsd.conf

# Allow remote admin
sed -i \
	-e "/<Location \/admin>/,/<\/Location>/{/<\/Location>/i\ \ Allow @LOCAL
}" \
	-e "/<Location \/admin\/conf>/,/<\/Location>/{/<\/Location>/i\ \ Allow @LOCAL
}" \
	/etc/cups/cupsd.conf

# Disable browsing
sed -i \
	-e "s,^Browsing.*,Browsing Off," \
	/etc/cups/cupsd.conf
