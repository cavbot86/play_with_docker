#!/bin/bash
set -e
source /etc/profile
source ${HOME}/.bashrc
env
mkdir -p ${WORKSPACE}/log
java -version > ${WORKSPACE}/log/test.log
tail -f ${WORKSPACE}/log/test.log