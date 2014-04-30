#!/bin/bash

docker run -d -h datanode --dns <dns_ip> -p 50075:50075 -p 8042:8042 <username>/hadoop-datanode
