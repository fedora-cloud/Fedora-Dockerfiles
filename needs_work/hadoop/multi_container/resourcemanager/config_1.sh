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

# Call all functions
__create_user
