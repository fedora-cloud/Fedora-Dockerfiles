dockerfiles-fedora-hadoop
========================

THIS DOCKERFILE NEEDS WORK - 1/9/2014

Fedora dockerfile for Hadoop

Tested on Docker 0.7.0

1. To build:

# docker build -rm -t <username>/hadoop . |& tee hadoop_build.log

2. To Run:

# ./run.sh

3. To confirm ports are available:

# docker ps 
CONTAINER ID        IMAGE       COMMAND       CREATED       STATUS    PORTS      NAMES
2eb142b5f9da        <username>/hadoop:latest   /config_2.sh        13 hours ago        Up 13 hours         0.0.0.0:13562->13562/tcp, 0.0.0.0:19888->19888/tcp, 0.0.0.0:50010->50010/tcp, 0.0.0.0:50020->50020/tcp, 0.0.0.0:50030->50030/tcp, 0.0.0.0:50060->50060/tcp, 0.0.0.0:50070->50070/tcp, 0.0.0.0:50075->50075/tcp, 0.0.0.0:50090->50090/tcp, 0.0.0.0:50105->50105/tcp, 0.0.0.0:58261->58261/tcp, 0.0.0.0:60010->60010/tcp, 0.0.0.0:8030->8030/tcp, 0.0.0.0:8031->8031/tcp, 0.0.0.0:8032->8032/tcp, 0.0.0.0:8033->8033/tcp, 0.0.0.0:8040->8040/tcp, 0.0.0.0:8042->8042/tcp, 0.0.0.0:8088->8088/tcp, 50700/tcp   thirsty_curie       


4. To access services, open a local browser and hit the following URLs.

http://localhost:50075 - Datanode
http://localhost:50090 - Secondary namenode
http://localhost:8088/cluster - Resource manager
http://localhost:8042/node - Yarn node manager


5. To run a job against the Hadoop container:

NEED TO FILL THIS IN.


