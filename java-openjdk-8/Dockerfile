FROM fedora
MAINTAINER "Marek Novotny" <mnovotny@redhat.com>

RUN yum -y update && yum clean all
RUN yum -y install tar gzip java java-devel && yum clean all

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# Define default command.
CMD ["bash"]
