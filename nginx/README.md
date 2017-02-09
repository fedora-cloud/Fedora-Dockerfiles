dockerfiles-fedora-nginx
========================

Fedora dockerfile for nginx

To build:

Copy the sources down -

    # docker build --rm -t fedora/nginx .

To run:

On Atomic host:

    # atomic run fedora/nginx

On Non-Atomic host:

    # docker run -d -p 80:80 fedora/nginx

To test:

    # curl http://localhost

