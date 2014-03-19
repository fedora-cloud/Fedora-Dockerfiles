#!/bin/bash -x

__hdfs_createdir() {
echo
echo "Running hdfs_createdir Function"
echo
runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -mkdir /user/test"
# su - hdfs -c "hadoop fs -mkdir /user/test"
runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -chown test /user/test"
# runuser hdfs -s /bin/bash /bin/bash -c "hadoop fs -chown test /user/test"
# hadoop fs -mkdir /user/test
# hadoop fs -chown test /user/test
}

__namenode_format() {
hadoop namenode -format
}

__run_supervisor() {
echo
echo "Running run_supervisor Function"
echo
supervisord -n
}

__start_hadoop() {
/sbin/hadoop-daemon.sh start datanode
/sbin/mr-jobhistory-daemon.sh start historyserver
/sbin/hadoop-daemon.sh start namenode
/sbin/yarn-daemon.sh start nodemanager
/sbin/yarn-daemon.sh start proxyserver
/sbin/yarn-daemon.sh start resourcemanager
/sbin/hadoop-daemon.sh start secondarynamenode
/sbin/hadoop-daemon.sh start zkfc
}



# Call all functions
__hdfs_createdir
# __namenode_format
__run_supervisor
# __start_hadoop
