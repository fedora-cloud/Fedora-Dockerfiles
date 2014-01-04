dockerfiles-fedora-hadoop
========================

Fedora dockerfile for Hadoop

Tested on Docker 0.7.0

To build:

Over the net via git -

```
docker build -rm -t <username>/hadoop git://github.com/scollier/dockerfiles-fedora-hadoop.git
```

or

Copy the sources down -

```
docker build -rm -t <username>/hadoop .
```


To run:

```
docker run -d -p 27017 <username>/hadoop
```


Watch for the database to initialize and start listening (using the container ID from "docker run":

```
docker logs 3a2aaa5b803f597732b18
<snip>
Tue Dec 17 20:34:42.655 [initandlisten] command local.$cmd command: { create: "startup_log", size: 10485760, capped: true } ntoreturn:1 keyUpdates:0  reslen:37 360ms
Tue Dec 17 20:34:42.661 [websvr] admin web console waiting for connections on port 28017
Tue Dec 17 20:34:42.725 [initandlisten] waiting for connections on port 27017
```

Get the port that the container is listening on:

```
# docker ps
CONTAINER ID        IMAGE                   COMMAND             CREATED             STATUS              PORTS                      NAMES
c8fc42d19fd3        <username>/hadoop:latest   /usr/bin/hadoopd     4 minutes ago       Up 4 minutes        0.0.0.0:49158->27017/tcp   ecstatic_thompson   
```

To test, use the port that was just located:

```
# hadoop --port 49158
Hadoop shell version: 2.4.6
connecting to: 127.0.0.1:49158/test
> 

```
