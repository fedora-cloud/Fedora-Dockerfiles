#!/bin/bash

docker run -d -h namenode --dns <dns_ip> -p 50070:50070 <username>/hadoop-namenode
