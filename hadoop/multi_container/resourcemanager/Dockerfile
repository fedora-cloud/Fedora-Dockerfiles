FROM fedora
MAINTAINER scollier <emailscottcollier@gmail.com>

# Update the container
RUN yum -y update && yum clean all

# Install the hadoop packages
RUN yum -y install hadoop-yarn hadoop-mapreduce hadoop-common-native pwgen ldapjdk supervisor bash-completion && yum clean all

# Install network troubleshooting tools into the container, these can be removed if you don't want them.
RUN yum -y install net-tools lsof nmap && yum clean all

ADD ./core-site.xml /etc/hadoop/
ADD ./supervisord.conf /etc/supervisord.conf

# These only expose what was given in: http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.0.6.0/bk_using_Ambari_book/content/reference_chap2_2a_2x.html
EXPOSE 8025 8141 8050 8030 8032 8088 8090 8031 8033 

# Mapreduce History Server Ports
EXPOSE 10020 19888

# Launch the supervisord service to manage all the hadoop processes.
CMD ["supervisord", "-n"]
