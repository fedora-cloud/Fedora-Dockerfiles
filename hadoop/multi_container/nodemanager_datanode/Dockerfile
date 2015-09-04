FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

# Update the container
RUN dnf -y update && dnf clean all

# Install the hadoop packages
RUN dnf -y install hadoop-hdfs hadoop-yarn hadoop-common-native hadoop-mapreduce pwgen ldapjdk supervisor bash-completion && dnf clean all

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN dnf -y install net-tools lsof nmap && dnf clean all

ADD ./supervisord.conf /etc/supervisord.conf
ADD ./core-site.xml /etc/hadoop/
ADD ./yarn-site.xml /etc/hadoop/

# Only ports shown: http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.0.6.0/bk_using_Ambari_book/content/reference_chap2_1_2x.html
# Datanode Ports
EXPOSE 50075 50475 50010 8010 50020

# Yarn Nodemanager Port
EXPOSE 45454 8042 8040

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
