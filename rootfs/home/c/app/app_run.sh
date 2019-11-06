#!/bin/bash
set -e
mkdir -p ${WORDSPACE}/log
java -version > ${WORDSPACE}/log/test.log
tail -f ${WORDSPACE}/log/test.log