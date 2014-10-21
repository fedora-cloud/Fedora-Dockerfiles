#!/bin/bash
sed -i \
	-e "0,/^Listen /{s,^Listen .*$,Port 631,}" \
	-e "/^Listen /d" \
	-e "/<Location \/>/,/<\/Location>/{/<\/Location>/i\ \ Allow @LOCAL
}" \
	-e "/<Location \/admin>/,/<\/Location>/{/<\/Location>/i\ \ Allow @LOCAL
}" \
	-e "/<Location \/admin\/conf>/,/<\/Location>/{/<\/Location>/i\ \ Allow @LOCAL
}" \
	-e "s,^Browsing.*,Browsing Off," \
	/etc/cups/cupsd.conf
