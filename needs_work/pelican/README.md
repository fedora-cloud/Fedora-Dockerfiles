dockerfiles-fedora-pelican
========================

Fedora dockerfile for pelican (http://docs.getpelican.com)
Based on lighttpd dockerfile
(https://git.fedorahosted.org/cgit/dockerfiles.git/tree/lighttpd)

Tested on Docker 0.9.x


Configuration
-----

You should prepare SSH public key and copy it to cfg_files/blog/.ssh/authorized_keys so you'll be able to login to the container (sshd config denies login to any
other user).

Installation
-----

Copy your SSH public key to authorized_keys:

    $ cat ~/.ssh/id_rsa.pub > cfg_files/blog/.ssh/authorized_keys

Prepare directories for logs and configs and htdocs:

    $ mkdir /srv/docker_mounts/pelican/{logs,configs,htdocs} -p

If you have prepared lighttpd.conf you can put it now in
/srv/docker_mounts/lighttpd/configs (this dir will be mounted as 
/etc/lighttpd in the container). If not than the default will be generated and
used by lighttpd daemon.

Clone Dockerfile somewhere and build the container:

    $ sudo docker build -t pelican --rm .

Take note of ssh blog user password during above build process - you'll
need that later:

    Step 17 : RUN /root/scripts/init.sh
    ...
    blog ssh password: YYYYYYYYY

And now run the container:

    $ sudo docker run -d -p 8092:80/tcp -v /srv/docker_mounts/blog/configs:/etc/lighttpd -v /srv/docker_mounts/blog/logs:/var/log/lighttpd -v /srv/docker_mounts/blog/htdocs/:/srv/httpd/htdocs --name=pelican -t pelican

In above example params means:

* -p 8092:80/tcp - let's forward external 8092 port from host to container port 80
* -v /srv/docker_mounts/blog/logs:/var/log/lighttpd:rw - mounting host
* /srv/.../logs dir in container's /var/log/lighttpd dir with rw rights

After running container it should be working fine and you should be able to ssh
to it using ssh key that you pasted before to cfg_files/blog/.ssh/authorized_keys

Testing
-----

TODO

Managing blog
-----

TODO

Managing configuration:
-----

TODO

Managing logfiles
-----

TODO
