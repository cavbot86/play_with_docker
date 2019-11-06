#!/bin/bash
set -e
source ${HOME}/.bashrc
env
mkdir -p ${WORKSPACE}/log
java -version > ${WORKSPACE}/log/test.log
tail -f ${WORKSPACE}/log/test.log