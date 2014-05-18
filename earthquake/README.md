dockerfiles-fedora-earthquake
========================

Fedora dockerfile for earthquake (terminal-based Twitter client:
https://github.com/jugyo/earthquake)

Installation
-----

Clone Dockerfile somewhere and run:

    $ sudo docker build -t earthquake .

    On docker 0.8.x:
    $ sudo docker run --rm -i -name earthquake -t earthquake
    
    On docker 0.9.x:
    $ sudo docker run --rm -i --name=earthquake -t earthquake

Could be run using TMux or GNU Screen

Plugins
-----

In order to install plugins just follow the steps from earthquake manuals;
Docker will keep those changed/new files untouched.
