dockerfiles-fedora-flask
========================

Fedora dockerfile for flask

To build:

Copy the sources down -

    # docker build --rm -t <username>/flask .

To run:

    # docker run -d -p 80:5000 <username>/flask

To test:

    # curl http://localhost

