dockerfiles-fedora-maven
========================

Fedora dockerfile for java development with maven

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build
```
# docker build --rm -t <username>/fedora_maven .
```

Run maven build from current host directory where you have your Maven project with pom.xml file:

```
# docker run -it --rm --name my-maven-docker -v "$PWD":/usr/src/mymaven <username>/fedora_maven mvn clean install -f /usr/src/mymaven/pom.xml
```

Example of test build where simple Maven project is generated from Maven Archetype:
```
# docker run -it --rm --name my-maven-docker <username>/fedora_maven mvn archetype:generate -B -DgroupId=org.fedoraproject -DartifactId=docker-maven-test -DarchetypeArtifactId=maven-archetype-quickstart
```

You can base your own image with specifying the Maven settings.xml and setting up another repository as mirror of Maven Central from environment property _mavenRepositoryUrl_ like 

```
FROM <username>/fedora_maven

# Could be used for images based on this Docker image to specify default mirrored repository
ENV mavenRepositoryUrl http://localhost:8081/nexus/content/groups/public/
ADD settings.xml /usr/share/maven/conf/settings.xml
```

Or you can run it with pointing environment property mavenRepositoryUrl to http://localhost:8081/nexus/content/groups/public/ and this will be replaced in default setting.xml file in running docker container:

```
# docker run -it --rm --name my-maven-docker -v "$PWD":/usr/src/mymaven --env mavenRepositoryUrl=http://localhost:8081/nexus/content/groups/public/ <username>/fedora_maven mvn clean install -f /usr/src/mymaven/pom.xml
```

