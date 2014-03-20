FROM fedora
MAINTAINER scollier <emailscottcollier@gmail.com>

# Update the container
RUN yum -y update

# Install the hadoop packages
# RUN yum -y install yum install hadoop-common hadoop-common-native hadoop-hdfs hadoop-mapreduce hadoop-mapreduce-examples hadoop-yarn pwgen java-1.7.0-openjdk-headless java-1.7.0-openjdk java-1.7.0-openjdk-devel ldapjdk supervisor bash-completion
# 
RUN yum -y install hadoop-yarn pwgen java-1.7.0-openjdk-headless java-1.7.0-openjdk java-1.7.0-openjdk-devel ldapjdk supervisor bash-completion

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN yum -y install net-tools lsof nmap

ADD ./yarn-site.xml /etc/hadoop/
ADD ./core-site.xml /etc/hadoop/
# ADD ./config_1.sh /config_1.sh
ADD ./supervisord.conf /etc/supervisord.conf

# RUN chmod 755 /config_1.sh
# RUN hadoop namenode -format -force

# Expose lots of ports, we might be able to pare this down a bit.
# The ones below expose everything
# EXPOSE 50090 50010 60010 50075 50020 8042 58261 8088 13562 8030 8031 8032 8033 19888 50070 8040 50105 50070 50030 50060 8020 50475 50470 50100 8485 8480 8080 10020 8090 9000 9001

# These only expose what was given in: http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.0.6.0/bk_using_Ambari_book/content/reference_chap2_2a_2x.html
# EXPOSE 8025 8141 8050 45454
EXPOSE 8025 8141 8050 8030 8032 8088 8090 8031 8033 

# RUN /config_1.sh

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
