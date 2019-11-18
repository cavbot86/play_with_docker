#!/bin/bash
set -e

IMAGE_TAG='cavbot/temp_for_test'
CONTAINER_NAME='docker_temp_test'
NETWORK_NAME='work'
CONTAINER_IP="`docker-get-subnet-prefix ${NETWORK_NAME}`.254.1"


CONTAINER_VOLUME=${DOCKER_VOLUMES}/${CONTAINER_NAME}

container_id=`sudo docker ps -a | grep ${CONTAINER_NAME} | awk '{print $1}'`
if [[ -n ${container_id} ]]; then
    sudo docker rm -f ${container_id}
fi

sudo rm -rf ${CONTAINER_VOLUME}
sudo mkdir -p ${CONTAINER_VOLUME}/data
sudo mkdir -p ${CONTAINER_VOLUME}/logs
sudo mkdir -p ${DOCKER_VOLUMES}/ssh_id_rsa

sudo docker run -it \
    -v ${CONTAINER_VOLUME}/data:/data \
    -v ${CONTAINER_VOLUME}/logs:/home/c/app/logs \
    -v ${DOCKER_VOLUMES}/ssh_id_rsa:/ssh_id_rsa \
    --name ${CONTAINER_NAME} \
    --network ${NETWORK_NAME} \
    --ip ${CONTAINER_IP} \
    ${IMAGE_TAG} "/start_app.sh & bash"

# sudo docker run -d \
#     -v ${CONTAINER_VOLUME}/data:/data \
#     -v ${CONTAINER_VOLUME}/logs:/home/c/app/logs \
#     -v ${DOCKER_VOLUMES}/ssh_id_rsa:/ssh_id_rsa \
#     --name ${CONTAINER_NAME} \
#     --network ${NETWORK_NAME} \
#     --ip ${CONTAINER_IP} \
#     ${IMAGE_TAG}

echo Container Ip Address: ${CONTAINER_IP}