#!/bin/bash

docker run -d -h resourcemgr --dns <dns_ip> -p 8088:8088 -p 8032:8032 <username>/hadoop-resourcemgr
