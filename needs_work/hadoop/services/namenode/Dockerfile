FROM fedora
MAINTAINER scollier <emailscottcollier@gmail.com>

RUN yum -y update
RUN yum -y install yum install hadoop-common hadoop-common-native hadoop-hdfs hadoop-mapreduce hadoop-mapreduce-examples hadoop-yarn pwgen java-1.7.0-openjdk-headless java-1.7.0-openjdk java-1.7.0-openjdk-devel ldapjdk supervisor bash-completion
RUN yum -y install nmap net-tools

ADD ./config_1.sh /config_1.sh
ADD ./core-site.xml /etc/hadoop/core-site.xml
ADD ./start_hadoop.sh /start_hadoop.sh
# ADD ./start_hadoop.sh /start_hadoop.sh
ADD ./hdfs-create-dirs /hdfs-create-dirs
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /config_1.sh
RUN chmod 755 /start_hadoop.sh
RUN chmod 755 /hdfs-create-dirs
RUN hadoop namenode -format -force
RUN /hdfs-create-dirs

# EXPOSE 8042 58261 8088 13562 8030 8031 8032 8033 19888 50070 8040 50105 50070 50030 50060 8020 50475 50470 50100 8485 8480 8080 10020 8090 9000 9001

EXPOSE 8020 50070

RUN /config_1.sh

# USER hdfs
# RUN hadoop fs -mkdir /user/test
# RUN hadoop fs -chown test /user/test
# USER 0

CMD ["supervisord", "-n"]
