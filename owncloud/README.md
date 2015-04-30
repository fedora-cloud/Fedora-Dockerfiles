dockerfiles-fedora-OwnCloud
===========================

This repo contains a recipe for making Docker container for OwnCloud on Fedora. 
The docker file chooses httpd and sqlite for owncloud. These can easily be changed
by changing what rpms get installed. This has been tested with docker 1.6.0 and 
owncloud-7.0.5.

Check your Docker version

    # docker version

Perform the build

    # docker build -t <yourname>/owncloud .

Check the image out.

    # docker images

Run it:

    # docker run -d -p 443:443 <yourname>/owncloud

You should now be able to view the OwnCloud setup page by going to https://localhost/owncloud

