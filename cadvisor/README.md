dockerfiles-fedora-cadvisor
========================

Fedora dockerfile for cadvisor

To build:

Copy the sources down -

    # docker build --rm -t <username>/cadvisor .

To run:

    # docker run --name cadvisor --privileged -v /run:/run:rw -v /sys:/sys:ro -v /var/lib/docker:/var/lib/docker:ro -d -p 8080:8080 <username>/cadvisor

To test:

    # curl http://localhost:8080

