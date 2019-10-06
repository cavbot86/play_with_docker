#!/bin/bash
set -e

/init.sh

echo "start run startup scripts..."
for var in $(ls /startup_scripts/*.sh)
do
    echo bash "$var"
    bash "$var"
done
echo "run startup scripts finished."

echo "network info: "
echo `ifconfig | grep inet`

echo start services ...
echo "################################################################################################"
/usr/bin/supervisord
echo $@
$@