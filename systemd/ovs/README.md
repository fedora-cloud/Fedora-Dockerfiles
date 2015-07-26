dockerfiles-fedora-ovs
========================

Fedora Dockerfile for openvswitch working with systemd.

For more information on systemd inside Docker containers, please see:
http://rhatdan.wordpress.com/2014/04/30/running-systemd-within-a-docker-container/

For more information on openvswitch inside Docker containers, please see:
https://github.com/socketplane/docker-ovs

To build:

Copy the sources down and do the build:

```
# docker build -t fedora/sysovs .
```

systemd in a container requires the mounting of the cgroup fs volume,
and ovs requires the NET_ADMIN capability.  To run ovs in userspace
mode (other modes documented
[here](https://github.com/socketplane/docker-ovs/blob/master/README.md#running-the-container)):

```
# cid=$(docker run -td --cap-add NET_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup fedora/sysovs)
```

To test that ovs is running:

```
# docker exec $cid ovs-vsctl show
```

To create bridges in userspace mode, set the datapath type to `netdev`
as advised in the Open vSwitch's
[INSTALL.userspace](http://git.openvswitch.org/cgi-bin/gitweb.cgi?p=openvswitch;a=blob;f=INSTALL.userspace;h=f54b93e2e54c2efdc88054519038d98390e4183c;hb=HEAD):

```
# docker exec $cid ovs-vsctl add-br br0
# docker exec $cid ovs-vsctl set bridge br0 datapath_type=netdev
# docker exec $cid ovs-vsctl add-port br0 eth0
```
