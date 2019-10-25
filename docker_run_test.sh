#!/bin/bash
IP_192=`cmd-get-ip-192`
PORT_1=58822

if [ -n "$IP_192" ]; then
    PORT_1=$IP_192:$PORT_1
fi

# rm -rf ${DOCKER_VOLUMES}/docker_temp_test
mkdir -p ${DOCKER_VOLUMES}/docker_temp_test

sudo docker run -d \
    -p $PORT_1:22 \
    --name docker_temp_test \
    cavbot/temp_for_test