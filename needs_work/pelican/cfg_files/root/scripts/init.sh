#!/bin/bash

# some ssh sec (disable root login, disable password-based auth):
sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
echo "AllowUsers blog" >> /etc/ssh/sshd_config
sed -ri 's/session(\s+)required(\s+)pam_loginuid\.so/#/' /etc/pam.d/sshd

mkdir /var/run/sshd
ssh-keygen -A

# create user blog:
SSH_USERPASS=`pwgen -c -n -1 8`
useradd -G wheel -d /home/blog blog
echo blog:$SSH_USERPASS | chpasswd
echo blog ssh password: $SSH_USERPASS
mkdir /home/blog/.ssh
mv /tmp/authorized_keys /home/blog/.ssh/
chown blog:blog /home/blog -R
 
chmod 600 /home/blog/.ssh/authorized_keys
chmod 700 /home/blog/.ssh

mkdir /home/blog/pelican
chown blog:blog /home/blog/pelican
