FROM fedora
MAINTAINER scollier <emailscottcollier@gmail.com>

# Update the container
RUN yum -y update

# Install the hadoop packages
RUN yum -y install hadoop-hdfs hadoop-common-native pwgen ldapjdk supervisor bash-completion

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN yum -y install net-tools lsof nmap

ADD ./hdfs-create-dirs /usr/sbin/hdfs-create-dirs
ADD ./core-site.xml /etc/hadoop/
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /usr/sbin/hdfs-create-dirs
RUN /usr/sbin/hdfs-create-dirs

# Only exposing: http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.0.6.0/bk_using_Ambari_book/content/reference_chap2_1_2x.html
EXPOSE 50070 50470 8020 9000 50090

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
