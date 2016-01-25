#!/bin/bash
# maintainer: dusty@dustymabe.com
set -ex -o pipefail

# Check to make sure a tag was passed in
[ "$1" == "" ] && echo "Must provide tag as argument" && exit 1

# Check to make sure required utilites are present
/usr/bin/which cpio docker mktemp rpm2cpio tar
/usr/bin/which yumdownloader || /usr/bin/which dnf

# cd to a temporary directory
tmpdir=$(mktemp -d)
pushd $tmpdir

# Get and extract busybox 
which yumdownloader && yumdownloader busybox || dnf download busybox
rpm2cpio busybox*rpm | cpio -imd
rm -f busybox*rpm

# Create symbolic links back to busybox
mkdir ./bin
for i in $(./sbin/busybox --list);do
    ln -s /sbin/busybox ./bin/$i
done

# Create container
tar -c . | docker import -c="CMD /bin/sh" - $1

# Go back to old pwd
popd
