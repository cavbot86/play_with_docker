#!/bin/bash
set -e
source ${HOME}/.bashrc
env
mkdir -p ${WORKSPACE}/log
echo "Hello world!" > ${WORKSPACE}/log/test.log
tail -f ${WORKSPACE}/log/test.log