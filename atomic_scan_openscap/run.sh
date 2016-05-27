#/bin/bash

echo ""
if [ ! -e /host/etc/atomic.d/atomic_scan_openscap ]; then
    echo "No atomic_scan_openscap file found in /etc/atomic.d.  This image requires you install it with 'atomic install docker.io/atomic_scan_openscap'"

else
    echo "This container/image is not meant to be run outside of the atomic command. You can use this image by issuing 'atomic scan <container|image>' to scan.  See 'atomic scan --help' for more information."

fi

echo ""

