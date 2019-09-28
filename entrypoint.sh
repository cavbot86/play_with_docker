#!/bin/bash

/init.sh

echo start services ...
echo "################################################################################################"
/usr/bin/supervisord
echo $@
$@