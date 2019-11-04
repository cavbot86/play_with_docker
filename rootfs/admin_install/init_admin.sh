#!/bin/bash
set -e

echo init root dir ...
rm -rf /root/.ssh
if [[ ! -d "/root/.ssh" ]]; then
    mkdir -p /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi

echo init /var/run/sshd ...
if [[ ! -d "/var/run/sshd" ]]; then
    mkdir -p /var/run/sshd
fi

mkdir /admin_run_log

mkdir -p /home/${SUDOER_USER}
mkdir -p /home/${SUDOER_USER}/.ssh
touch /home/${SUDOER_USER}/.ssh/authorized_keys
chmod 600 /home/${SUDOER_USER}/.ssh/authorized_keys

echo "alias ll='ls -al'" >> /home/${SUDOER_USER}/.bashrc

chown -R ${SUDOER_USER}:${SUDOER_USER} /admin_run_log
chown -R ${SUDOER_USER}:${SUDOER_USER} /home/${SUDOER_USER}
chown -R ${SUDOER_USER}:${SUDOER_USER} /var/log
chown -R ${SUDOER_USER}:${SUDOER_USER} /var/run
chown -R ${SUDOER_USER}:${SUDOER_USER} /run