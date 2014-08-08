dockerfiles-fedora-wordpress
========================

Tested on Docker 0.7.2

When you run the below commands, simply use sudo. This is a [known issue](https://twitter.com/docker/status/366040073793323008).)

This repo contains a recipe for making a [Docker](http://docker.io) container for Wordpress, using Linux, Apache and MySQL on Fedora. 
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone this repo somewhere, and then run:

\# docker build --rm -t <yourname>/wordpress .


Or, alternately, build DIRECTLY from the github repo:

\# docker build --rm -t <username>/wordpress git://github.com/scollier/dockerfiles-fedora-wordpress.git


Run it:

\# docker run -d -p 80 -p 22 <yourname>/wordpress


Check docker logs after running to see MySQL root password and Wordpress MySQL password, as so:


\# echo $(docker logs <container-id> | grep password)


(note: you won't need the mysql root or the wordpress db password normally)

Then find the external port assigned to your container:


\# docker port <container-id> 80 


Note that this image now has a user account (appropriately named "user") and passwordless sudo for that user account. The password is generated upon startup; check logs for "ssh user password", docker ps for the port assigned to 22, and something like this to get in: 


\# ssh -p <port> user@localhost


