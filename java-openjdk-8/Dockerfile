FROM fedora
MAINTAINER http://fedoraproject.org/wiki/Cloud

RUN yum -y update && yum clean all
RUN yum -y install tar gzip java java-devel && yum clean all

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Define default command.
CMD ["bash"]
