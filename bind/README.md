dockerfiles-fedora-bind
========================

Fedora dockerfile for Bind - based resolving & cache'ing (DNS server)

Built on : Docker version 1.9.1
Run on: Docker version 1.9.1
Tested on : Docker version 1.9.1

Configuration
-----

You should configure legit networks in cfg_files/named.conf in order to allow
those to query this DNS server. By default legit networks are 127.0.0.1 and
whole 172.16.0.0/12 private network (as Docker uses those ranges for internal
networking).

Installation
-----

Edit allowed networks in named.conf:

    $ vim cfg_files/named.conf

Prepare directories for logs and configs (e.g. if want to use zone files):

    $ mkdir /srv/docker_mounts/bind/{logs,configs} -p

Now copy your zonefiles and rest of the configs (except for named.conf which
will be copied by initscript from cfg_files/named.conf) to the
/srv/docker_mounts/bind/configs (this dir will be mounted as /etc/named in the
container).

Clone Dockerfile somewhere and build the container:

    $ docker build -t bind --rm .

And now run the container:

    $ docker run -d --dns=127.0.0.1 -p 53:53/udp -p 53:53/tcp --name=bind -v /srv/docker_mounts/bind/logs:/var/log/named:rw -v /srv/docker_mounts/bind/configs:/etc/named:rw bind

In above examples params means:

* - dns 127.0.0.1 - this is a way to use 127.0.0.1 as DNS server in the container
* -p 53:53/udp(tcp) - let's forward external ports from host to container ports (53 - for DNS)
* -v /srv/docker_mounts/bind/logs:/var/log/named:rw - mounting host /srv/.../logs dir in container's /var/log/named dir with rw rights
* -v /srv/docker_mounts/bind/configs:/etc/named:rw - same as above

Testing
-----

Just use tools like dig. First check the IP address assigned to container:

    $ docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container_id|container_name>

And next use use dig:

    $ dig google.com @container_IP_ADDR

Managing own zone files (domains)
-----

In order to change configuration just edit cfg files in host
/srv/docker_mounts/bind/configs (remember that this dir is mounted on
/etc/named/ in container) and run a command:

    $ docker exec -it <container_id|container_name> rndc reload

Managing logfiles
-----

You can access logfiles within host in /srv/docker_mounts/bind/logs.

You could also switch off logging of all DNS queries (it is turned on in the
included named.conf) - just comment out following lines:

```
        channel log_queries {
                file "/var/log/named/named_queries.log" versions 3 size 20m;
                print-category yes;
                print-severity yes;
                print-time yes;
        };
