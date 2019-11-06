#!/bin/bash
set -e
env
mkdir -p ${WORKSPACE}/log
java -version > ${WORKSPACE}/log/test.log
tail -f ${WORKSPACE}/log/test.log