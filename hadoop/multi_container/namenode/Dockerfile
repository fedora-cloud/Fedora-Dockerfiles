FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Update the container
RUN dnf -y update && dnf clean all

# Install the hadoop packages
RUN dnf -y install hadoop-hdfs hadoop-common-native pwgen ldapjdk supervisor bash-completion && dnf clean all

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN dnf -y install net-tools lsof nmap && dnf clean all

ADD ./hdfs-create-dirs /usr/sbin/hdfs-create-dirs
ADD ./core-site.xml /etc/hadoop/
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start-hadoop-namenode /usr/sbin/start-hadoop-namenode

RUN chmod 755 /usr/sbin/hdfs-create-dirs
RUN chmod 755 /usr/sbin/start-hadoop-namenode

# Only exposing: http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.0.6.0/bk_using_Ambari_book/content/reference_chap2_1_2x.html
EXPOSE 50070 50470 8020 9000 50090

# Launch the supervisord service to manage all the hadoop processes.
CMD ["start-hadoop-namenode"]
