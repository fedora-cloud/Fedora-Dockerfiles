#/bin/bash
ETC='/etc/oscapd'
ETC_FILE='config.ini'
HOST='/host'


echo ""
echo "Installing the configuration file 'atomic_scan_openscap' into /etc/atomic.d/.  You can now use this scanner with atomic scan with the --scanner atomic_scan_openscap command-line option.  You can also set 'atomic_scan_openscap' as the default scanner in /etc/atomic.conf.  To list the scanners you have configured for your system, use 'atomic scan --list'."

echo ""
cp /root/atomic_scan_openscap /host/etc/atomic.d/



# Check if /etc/oscapd exists on the host
if [[ ! -d ${HOST}/${ETC} ]]; then
    mkdir ${HOST}/${ETC}
fi

DATE=$(date +'%Y-%m-%d-%T')

# Check if /etc/oscapd/config.ini exists
if [[ -f ${HOST}/${ETC}/${ETC_FILE} ]]; then
    SAVE_NAME=${ETC_FILE}.${DATE}.atomic_save
    echo "Saving current ${ETC_FILE} as ${SAVE_NAME}"
    mv ${HOST}/${ETC}/${ETC_FILE} ${HOST}/${ETC}/${SAVE_NAME}
fi

# Add config.ini to the host filesystem
echo "Updating ${ETC_FILE} with latest configuration"
cp /root/config.ini ${HOST}/${ETC}/

# Exit Message
echo "Installation complete. You can customize ${ETC}/${ETC_FILE} as needed."


echo ""
