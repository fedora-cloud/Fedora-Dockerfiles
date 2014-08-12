dockerfiles-fedora-memcached
========================

Fedora dockerfile for memcached

Get the version of Docker:

    # docker version

To build:

Copy the sources down -

    # docker build --rm -t <username>/memcached .

To run:

    # docker run -d -p 11211:11211 <username>/memcached

Test:

```
# telnet localhost 11211
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
stats
STAT pid 1
STAT uptime 165
STAT time 1387383960
STAT version 1.4.15
STAT libevent 2.0.21-stable
<snip>
```
