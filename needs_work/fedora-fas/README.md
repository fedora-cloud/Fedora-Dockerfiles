dockerfiles-fedora-FAS
========================

Fedora dockerfile for Fedora Account System

Tested on Docker 0.8.0

Full Docker manualt can be fetched from http://docker.io

Installation
----

Copy the sources and run the build process:

    $ docker build --rm -t <username>/fas .

Running
----

NATting external host 80 port to internal port 80 on container:

    $ docker run -d -p 80:80 <username>/fas

Assigning a random port that maps to port 80 on the container:

    $ docker run -d -p 80 <username>/fas
