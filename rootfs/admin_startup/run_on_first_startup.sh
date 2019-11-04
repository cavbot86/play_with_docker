#!/bin/bash
set -e

## run once
echo "run once start: `date`"
echo renew ssh keys ...
sudo rm -f /etc/ssh/ssh_host_rsa_key
sudo ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
sudo rm -f /etc/ssh/ssh_host_ecdsa_key
sudo ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
sudo rm -f /etc/ssh/ssh_host_ed25519_key
sudo ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519

sudo ssh-keygen -f /root/.ssh/id_rsa -N "" -t rsa -b 4096 -C "${EMAIL}"

echo "init root password ..."
if [[ -z "${ROOT_INIT_PASSWORD}" ]]; then
    ROOT_INIT_PASSWORD=`openssl rand -base64 16 | head -c10`
fi
echo "################################################################################################"
echo "#"
echo "# The root password is ${ROOT_INIT_PASSWORD} , you can find it in ${ADMIN_RUN_DATA}/init_root_password"
echo "#"
echo "################################################################################################"
echo ${ROOT_INIT_PASSWORD} > ${ADMIN_RUN_DATA}/init_root_password
echo "root:${ROOT_INIT_PASSWORD}" | sudo chpasswd
echo ""
echo ""

echo "init sudoer user..."
if [[ -z "${SUDOER_USER_INIT_PASSWORD}" ]]; then
    SUDOER_USER_INIT_PASSWORD=`openssl rand -base64 16 | head -c10`
fi
echo "################################################################################################"
echo "#"
echo "# The sudoer password is ${SUDOER_USER_INIT_PASSWORD} , you can find it in ${ADMIN_RUN_DATA}/init_sudoer_password"
echo "#"
echo "################################################################################################"
echo ${SUDOER_USER_INIT_PASSWORD} > ${ADMIN_RUN_DATA}/init_sudoer_password
echo "${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD}" | sudo chpasswd
echo ""
echo ""

ssh-keygen -f /home/${SUDOER_USER}/.ssh/id_rsa -N "" -t rsa -b 4096 -C "${EMAIL}"
chmod 600 /home/${SUDOER_USER}/.ssh/id_rsa

echo "run once finished: `date`"