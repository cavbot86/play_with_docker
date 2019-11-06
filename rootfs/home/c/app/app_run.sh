#!/bin/bash
set -e
mkdir -p ${WORDSPACE}/log
java -version > ${WORDSPACE}/log/java.log
tail -f ${WORDSPACE}/log/java.log