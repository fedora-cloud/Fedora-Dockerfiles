#!/bin/bash

/usr/sbin/hadoop-daemon.sh start datanode
/usr/sbin/mr-jobhistory-daemon.sh start historyserver
/usr/sbin/hadoop-daemon.sh start namenode -format
/usr/sbin/yarn-daemon.sh start nodemanager
/usr/sbin/yarn-daemon.sh start proxyserver
/usr/sbin/yarn-daemon.sh start resourcemanager
/usr/sbin/hadoop-daemon.sh start secondarynamenode
/usr/sbin/hadoop-daemon.sh start zkfc

