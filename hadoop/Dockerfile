FROM mattdm/fedora
MAINTAINER scollier <emailscottcollier@gmail.com>

RUN yum -y update
RUN yum -y install yum install hadoop-common hadoop-common-native hadoop-hdfs hadoop-mapreduce hadoop-mapreduce-examples hadoop-yarn pwgen java-1.7.0-openjdk-headless java-1.7.0-openjdk java-1.7.0-openjdk-devel ldapjdk supervisor bash-completion

ADD ./config.sh /config.sh
ADD ./start_hadoop.sh /start_hadoop.sh
ADD ./hdfs-create-dirs /hdfs-create-dirs
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /config.sh
RUN chmod 755 /hdfs-create-dirs

EXPOSE 50090
# EXPOSE 50010
# EXPOSE 50075
# EXPOSE 50020
# EXPOSE 8042
# EXPOSE 58261
# EXPOSE 8088
# EXPOSE 13562
# EXPOSE 8030
# EXPOSE 8031
# EXPOSE 8032
# EXPOSE 8033
# EXPOSE 8040

# RUN runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -mkdir /user/test"
# RUN runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -chown test /user/test"


RUN /config.sh
CMD ["/start_hadoop.sh"]
