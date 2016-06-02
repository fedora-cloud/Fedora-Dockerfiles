dockerfiles-fedora-jenkins-slave
================================

Fedora dockerfile for jenkins slave
We can use it as jenkins slave while using containers as slave using Docker plugins in jenkins

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build

```
# docker build --rm -t <username>/fedora_jenkins_slave .
```
Instructions to be followed:

1. install docker plugin in jenkins

2. add this line -H fd:// -H tcp://0.0.0.0:2376 in addition to ExecStart, so it should look like this,

ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:2376

3. sudo systemctl daemon-reload

4. sudo systemctl restart docker

5. goto jenkins> manage jenkins > configure system > Add new cloud

6. select docker cloud, fill required details docker URL(:2376), label, remote filling system to /home/jenkins , docker image name(this docker image) and start to configure job.

7. put label of docker cloud in restrict where this project can be run. and build the job.
