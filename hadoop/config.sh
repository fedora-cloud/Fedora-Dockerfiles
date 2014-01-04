#!/bin/bash -x

__create_user() {
echo
echo "Running create_user Function"
echo
# Create a user to SSH into as.
# SSH_USERPASS=`pwgen -c -n -1 8`
useradd test
usermod -G wheel test
# echo test:$SSH_USERPASS | chpasswd
# echo ssh user password: $SSH_USERPASS
}

__hdfs_config() {
echo
echo "Running hdfs_config Function"
echo
sh -x /hdfs-create-dirs
}

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
__create_user
__hdfs_config
# __start_hadoop
# __hdfs_createdir
# __run_supervisor
__hdfs_createdir
