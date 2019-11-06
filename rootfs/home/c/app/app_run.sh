#!/bin/bash
set -e
mkdir -p ${WORDSPACE}/log
echo "Hello world!" > ${WORDSPACE}/log/test.log
tail -f ${WORDSPACE}/log/test.log