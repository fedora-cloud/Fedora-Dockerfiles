dockerfiles-fedora-busybox
===========================

This repo contains a recipe for making a Docker base image with just busybox in the
image. Rather than use another image as a base image this focuses on creating a docker
image from local files that are downloaded and then fed via tar into docker import.

Check your Docker version

    # docker version

Create the image with the tag 'mybusybox'

    # ./makeimage.sh mybusybox

Check the image out.

    # docker images

Run it:

    # docker run -i -t mybusybox sh

You should now have a shell inside a busybox container.

