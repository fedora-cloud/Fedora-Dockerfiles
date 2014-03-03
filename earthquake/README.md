dockerfiles-fedora-earthquake
========================

Fedora dockerfile for earthquake (terminal-based Twitter client:
https://github.com/jugyo/earthquake)

Tested on Docker 0.8.0

Installation
-----

Clone Dockerfile somewhere and run:

    $ sudo docker build -t earthquake .
    $ sudo docker run --rm -i -name earthquake -t earthquake

Could be run using TMux or GNU Screen

Plugins
-----

In order to install plugins just follow the steps from earthquake manuals;
Docker will keep those changed/new files untouched.
