dockerfile-fedora-documentation
===============================

Fedora Dockerfile used for creating documentation for the "Containers Best Practices" guide.

Get the version of Docker

```
# docker version
```

To build:

Copy the sources down -

```
sudo docker build -t fedora/container-best-practices .
```

To run: 

This Docker image / container is meant to process asciidoc documentation for the following repository:

https://github.com/projectatomic/container-best-practices

* Clone the repo above

```
git clone https://github.com/projectatomic/container-best-practices.git
```

* Change into the "container-best-practices" directory

* Run the container and change the "-v" option to tpoin tot the location of the clone you just made.  There are two ways to run this contianer; 1. with a "make" 2. with a "make clean". 

* To render a new set of docs; run it with a "make" and look at the results.  You will see a labs.pdf and a labs.html.  If you see those, it worked.

```
$ docker run --privileged -v /home/scollier/git_projects/container-best-practices:/workdir -dt fedora/docs make 
d2ec472e40396b3186ec0c5863118ebc07ba2f649889b668472baf4c4ecc6bb5

$ ls
content  docker  labs.adoc  labs.fo  labs.html  labs.pdf  labs.xml  Makefile  README.adoc  README.md  scripts
```

* To clean up the directory to render a new set of docs, run the following command and look at the results. After running a "make clean", you should no longer see a labs.pdf or a labs.html.  If those are gone, then the "make clean" worked.

```
$ docker run --privileged -v /home/scollier/git_projects/container-best-practices:/workdir -dt fedora/docs make clean
46e04887c80d33f0050af37c3c7c4384d5dd96bd376c41a404ab79dd4ac5c139

$ ls
content  docker  labs.adoc  Makefile  README.adoc  README.md  scripts
```

