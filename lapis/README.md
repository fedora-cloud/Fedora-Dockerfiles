dockerfiles-fedora-lapis
========================

Fedora dockerfile for Lapis (a web framework for Lua or MoonScript)

Tested on Docker 1.4.0

To build:

Copy the sources down and do the build-


\# docker build --rm -t \<username\>/lapis .



To run:


\# docker run -d -p 8080:8080 \<username\>/lapis


To test:


\# curl http://localhost:8080


Example develop:


\# su -c "setenforce 0"

\# docker run -d -p 8080:8080 -v /path/to/your_lapis_project:/opt/webapp \<username\>/lapis

/opt/webapp - WORKDIR for lapis server
Now you can develop lapis project in /path/to/your_lapis_project and test on http://localhost:8080
