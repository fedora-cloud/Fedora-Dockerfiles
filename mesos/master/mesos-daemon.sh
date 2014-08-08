#!/usr/bin/env bash

prefix=/usr
exec_prefix=/usr

deploy_dir=/etc/mesos

# Increase the default number of open file descriptors.
ulimit -n 8192

PROGRAM=${1}

shift # Remove PROGRAM from the argument list (since we pass ${@} below).

test -e ${deploy_dir}/${PROGRAM}-env.sh && source ${deploy_dir}/${PROGRAM}-env.sh

/usr/sbin/${PROGRAM} ${@}
