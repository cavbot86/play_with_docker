#!/bin/bash
set -e
java -version > ${WORDSPACE}/java.log
tail -f ${WORDSPACE}/java.log