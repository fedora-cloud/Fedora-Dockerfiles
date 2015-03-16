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

Run maven build from current host directory where you have your Maven project in docker

```
# docker run -it --rm --name my-maven-docker -v "$PWD":/usr/src/mymaven <username>/fedora_maven mvn clean install -f /usr/src/mymaven/pom.xml
```

You can base your own image with specifying the Maven settings.xml and limiting the Central repository to the URL from environment property like 

```
FROM <username>/fedora_maven

# Could be used for images based on this Docker image to specify default mirrored repository
ENV mavenRepositoryUrl http://localhost:8081/nexus/content/groups/public/
ADD settings.xml /usr/share/maven/conf/settings.xml
```

And then you can run it with setting.xml to point for instance to http://10.200.138.76:8081/nexus/content/groups/public/

```
# docker run -it --rm --name my-maven-docker -v "$PWD":/usr/src/mymaven --env mavenRepositoryUrl=http://10.200.138.76:8081/nexus/content/groups/public/ <username>/fedora_maven mvn clean install -f /usr/src/mymaven/pom.xml
```

