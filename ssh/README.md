dockerfiles-fedora-ssh
========================

Fedora dockerfile for ssh

Tested on Docker 0.7.0

To build:

Copy the sources down -


\# docker build -rm -t <username>/ssh .



To run:


\# docker run -d -p 22 <username>/ssh


Get the port that the container is listening on:


\# docker ps
CONTAINER ID        IMAGE                 COMMAND             CREATED             STATUS              PORTS                   NAMES
8c82a9287b23        <username>/ssh:latest   /usr/sbin/sshd -D   4 seconds ago       Up 2 seconds        0.0.0.0:49154->22/tcp   mad_mccarthy        


To test, use the port that was just located:


\# ssh -p xxxx user@localhost 

