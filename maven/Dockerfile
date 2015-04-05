FROM fedora

RUN yum -y update && yum clean all
RUN yum -y install tar gzip java java-devel && yum clean all

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-openjdk

# set installed Maven version
ENV MAVEN_VERSION 3.2.5

# Download and install Maven
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
&& mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
&& ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Could be used for images based on this Docker image to specify default mirrored repository
#ENV mavenRepositoryUrl http://localhost:8081/nexus/content/groups/public/
#ADD settings.xml /usr/share/maven/conf/settings.xml

ENV M2_HOME /usr/share/maven
CMD ["mvn"]
