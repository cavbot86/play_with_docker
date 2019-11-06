#!/bin/bash
IP_192=`cmd-get-ip-192`
PORT_1=58822

if [ -n "$IP_192" ]; then
    PORT_1=$IP_192:$PORT_1
fi

# rm -rf ${DOCKER_VOLUMES}/docker_temp_test
mkdir -p ${DOCKER_VOLUMES}/docker_temp_test/ubuntu-base-flat/data
mkdir -p ${DOCKER_VOLUMES}/docker_temp_test/ubuntu-base-flat/home
mkdir -p ${DOCKER_VOLUMES}/ssh_id_rsa


sudo docker run -it \
    -p $PORT_1:22 \
    -v ${DOCKER_VOLUMES}/docker_temp_test/ubuntu-base-flat/data:/data \
    -v ${DOCKER_VOLUMES}/docker_temp_test/ubuntu-base-flat/home:/home \
    -v ${DOCKER_VOLUMES}/ssh_id_rsa:/ssh_id_rsa \
    --name docker_temp_test \
    --network work  \
    cavbot/temp_for_test bash

# sudo docker run -d \
#     -p $PORT_1:22 \
#     -v ${DOCKER_VOLUMES}/docker_temp_test/ubuntu-base-flat/data:/data \
#     -v ${DOCKER_VOLUMES}/ssh_id_rsa:/ssh_id_rsa \
#     --name docker_temp_test \
#     --network work  \
#     cavbot/temp_for_test bash