#!/bin/bash
set -e
echo "do some prepare..."
scp -r ${HOME_INIT} /home
