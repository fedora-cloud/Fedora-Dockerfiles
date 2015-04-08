FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Update the container
RUN yum -y update

# Install the hadoop packages
RUN yum -y install yum install hadoop-common hadoop-common-native hadoop-hdfs hadoop-mapreduce hadoop-mapreduce-examples hadoop-yarn pwgen java-1.7.0-openjdk-headless java-1.7.0-openjdk java-1.7.0-openjdk-devel ldapjdk supervisor bash-completion && yum clean all

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN yum -y install net-tools lsof nmap && yum clean all

ADD ./config_1.sh /config_1.sh
ADD ./start_hadoop.sh /start_hadoop.sh
ADD ./hdfs-create-dirs /hdfs-create-dirs
ADD ./core-site.xml /etc/hadoop/
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /config_1.sh
RUN chmod 755 /start_hadoop.sh
RUN chmod 755 /hdfs-create-dirs
RUN hadoop namenode -format -force
RUN /hdfs-create-dirs

# Expose lots of ports, we might be able to pare this down a bit.
EXPOSE 50090 50010 60010 50075 50020 8042 58261 8088 13562 8030 8031 8032 8033 19888 50070 8040 50105 50070 50030 50060 8020 50475 50470 50100 8485 8480 8080 10020 8090 9000 9001

RUN /config_1.sh

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
