#!/bin/bash
set -e

/init.sh

echo start services ...
echo "################################################################################################"
/usr/bin/supervisord
echo $@
$@