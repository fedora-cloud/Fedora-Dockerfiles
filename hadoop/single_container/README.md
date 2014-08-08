dockerfiles-fedora-hadoop
========================

Fedora dockerfile for Hadoop - Single container, multi-service.  No external volume.

1. To build:

        # docker build --rm -t <username>/hadoop-single . |& tee hadoop_build.log

        # docker images

2. To Run:

        # ./run.sh

        # docker ps

    Make sure to replace <username> in the run.sh file.

3. To confirm ports are available:

        # docker ps
        CONTAINER ID        IMAGE                           COMMAND             CREATED             STATUS              PORTS        NAMES
        de33e77a7d73        <username>/hadoop-single:latest   supervisord -n      6 seconds ago       Up 4 seconds        0.0.0.0:10020->10020/tcp, 0.0.0.0:13562->13562/tcp, 0.0.0.0:19888->19888/tcp, 0.0.0.0:50010->50010/tcp, 0.0.0.0:50020->50020/tcp, 0.0.0.0:50030->50030/tcp, 0.0.0.0:50060->50060/tcp, 0.0.0.0:50070->50070/tcp, 0.0.0.0:50075->50075/tcp, 0.0.0.0:50090->50090/tcp, 0.0.0.0:50100->50100/tcp, 0.0.0.0:50105->50105/tcp, 0.0.0.0:50470->50470/tcp, 0.0.0.0:50475->50475/tcp, 0.0.0.0:58261->58261/tcp, 0.0.0.0:60010->60010/tcp, 0.0.0.0:8020->8020/tcp, 0.0.0.0:8030->8030/tcp, 0.0.0.0:8031->8031/tcp, 0.0.0.0:8032->8032/tcp, 0.0.0.0:8033->8033/tcp, 0.0.0.0:8040->8040/tcp, 0.0.0.0:8042->8042/tcp, 0.0.0.0:8080->8080/tcp, 0.0.0.0:8088->8088/tcp, 0.0.0.0:8090->8090/tcp, 0.0.0.0:8480->8480/tcp, 0.0.0.0:8485->8485/tcp, 0.0.0.0:9000->9000/tcp, 9001/tcp   hungry_pasteur

4. To access services, open a local browser and hit the following URLs.

        # curl http://localhost:50075 - Datanode
        # curl http://localhost:50090 - Secondary namenode
        # curl http://localhost:8088/cluster - Resource manager
        # curl http://localhost:8042/node - Yarn node manager

5. To run a job against the Hadoop container.  Install the following packages:
    - hadoop-mapreduce-examples
    - hadoop-common

6. Make sure the `core-site.xml` file has the proper networking.

        # grep hdfs /etc/hadoop/core-site.xml
        <value>hdfs://0.0.0.0:8020</value>

7. Run a job.

        # hadoop jar /usr/share/java/hadoop/hadoop-mapreduce-examples.jar pi 10 100000

        <snip>
        		Total committed heap usage (bytes)=1956642816
        	Shuffle Errors
        		BAD_ID=0
        		CONNECTION=0
        		IO_ERROR=0
        		WRONG_LENGTH=0
        		WRONG_MAP=0
        		WRONG_REDUCE=0
        	File Input Format Counters 
        		Bytes Read=1180
        	File Output Format Counters 
        		Bytes Written=97
        Job Finished in 63.565 seconds


Misc:

Useful commands for checking out hadoop inside the container:

    # hdfs dfsadmin -report
    # mapred queue -list
