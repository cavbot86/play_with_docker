#!/bin/bash
set -e

echo "Replace id_rsa if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/id_rsa" ]]; then
    sudo cp -f ${SSH_ID_RSA_DIR}/id_rsa /root/.ssh/id_rsa
    sudo chmod 600 /root/.ssh/id_rsa
fi

echo "Replace id_rsa.pub if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/id_rsa.pub" ]]; then
    sudo cp -f ${SSH_ID_RSA_DIR}/id_rsa.pub /root/.ssh/id_rsa.pub
fi

echo "Replace id_rsa.pub if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/authorized_keys" ]]; then
    sudo cp -f ${SSH_ID_RSA_DIR}/authorized_keys /root/.ssh/authorized_keys
    sudo chmod 600 /root/.ssh/authorized_keys
fi