#!/bin/bash
set -e

echo "Replace id_rsa if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/id_rsa" ]]; then
    cp -f ${SSH_ID_RSA_DIR}/id_rsa /home/${SUDOER_USER}/.ssh/id_rsa
    chmod 600 /home/${SUDOER_USER}/.ssh/id_rsa
fi

echo "Replace id_rsa.pub if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/id_rsa.pub" ]]; then
    cp -f ${SSH_ID_RSA_DIR}/id_rsa.pub /home/${SUDOER_USER}/.ssh/id_rsa.pub
    chmod 644 /home/${SUDOER_USER}/.ssh/id_rsa.pub
fi

echo "Replace id_rsa.pub if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/authorized_keys" ]]; then
    cp -f ${SSH_ID_RSA_DIR}/authorized_keys /home/${SUDOER_USER}/.ssh/authorized_keys
    chmod 600 /home/${SUDOER_USER}/.ssh/authorized_keys
fi

echo "Replace known_hosts if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
if [[ -f "${SSH_ID_RSA_DIR}/known_hosts" ]]; then
    cp -f ${SSH_ID_RSA_DIR}/known_hosts /home/${SUDOER_USER}/.ssh/known_hosts
    chmod 644 /home/${SUDOER_USER}/.ssh/known_hosts
fi

mkdir -p ${WORKSPACE}
chown -R ${SUDOER_USER}.${SUDOER_USER} ${WORKSPACE}
