docker-multi-container-hadoop
=============================

Directories containing dockerfiles and support files for running hadoop
as separate services in docker containers.

namenode - Files for a hadoop namenode
nodemanager_datanode - Files for a hadoop datanode and nodemanager
resourcemaanger - Files for a hadoop resource manager

In order for hadoop to function, a DNS server is required that will resolve
the hostnames given to the containers at startup.  The hadoop configuration
is tied to specific hostnames for the namenode and the resource manager
containers.  For the containers to find each other and function, the DNS
server should have entries for these names:

namenode - The IP of the namenode container
resourcemgr - The IP of the resource manager container

The DNS server will also need to support reverse DNS lookups for all
hostnames given to containers.

DNS setup

DNS is required for hadoop to function.  On a single node running all three
containers this can be accomplished by configuring and running dnsmasq.
Have dnsmasq listen on the docker interface (default: docker0) by adding
the following to the dnsmasq.conf file:

interface=docker0

Create a 0hosts file in /etc/dnsmasq.d and add the following entries:

address="/namenode/<namenode_ip>"
ptr-record=<reverse_namenode_ip>.in-addr.arpa,namenode
address="/resourcemgr/<resourcemgr_ip>"
ptr-record=<reserve_resourcemgr_ip>.in-addr.arpa,resourcemgr
address="/datanode/<datanode_ip>"
ptr-record=<reverse_datanode_ip>.in-addr.arpa,datanode1

Replace the <> values with the corresponding IP information.  For example,
if the namenode ip is 172.17.0.2, then the corresponding entries would be:

address="/namenode/172.17.0.2"
ptr-record=2.0.17.172.in-addr.arpa,namenode

Starting the containers

The hadoop containers need to be started in a specific order, otherwise some
hadoop service will fail to start.  Start the containers in the following
order:

1. namenode
2. resource manager
3. datanode

To access services once all the containers are started, open a local browser
and hit the following URLs.

http://localhost:50070 - Namenode
http://localhost:50075 - Datanode
http://localhost:8088 - Resource manager
http://localhost:8042 - Yarn node manager

To run a job against the Hadoop cluster in the containers.  Install the
following packages on the host:

hadoop-common
hadoop-mapreduce-examples

Make sure the core-site.xml file is pointing at the namenode and the
resource manager running in containers.

  <property>
    <name>fs.default.name</name>
    <value>hdfs://<namenode_ip>:8020</value>
  </property>

  <property>
    <name>yarn.resourcemanager.hostname</name>
    <value><resourcemgr_ip></value>
  </property>

Run a job.

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

	# hdfs dfsadmin -report (Must be run as hdfs user)
	# mapred queue -list

