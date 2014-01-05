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

__run_supervisor() {
echo
echo "Running run_supervisor Function"
echo
supervisord -n
}


# Call all functions
__hdfs_createdir
__run_supervisor
