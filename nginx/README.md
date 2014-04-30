dockerfiles-fedora-nginx
========================

Fedora dockerfile for nginx

Tested on Docker 0.7.0

To build:

Copy the sources down -

    # docker build -rm -t <username>/nginx .

To run:

    # docker run -d -p 80:80 <username>/nginx

To test:

    # curl http://localhost

