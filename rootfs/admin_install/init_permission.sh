#!/bin/bash
set -e


chown -R ${SUDOER_USER}:${SUDOER_USER} /home/${SUDOER_USER}
chown -R ${SUDOER_USER}.${SUDOER_USER} ${HOME_INIT}

chown -R ${CMD_USER}:${CMD_USER} ${ADMIN_RUN}
chown -R ${CMD_USER}:${CMD_USER} ${WORKSPACE} 
chown -R ${CMD_USER}:${CMD_USER} /var/log
chown -R ${CMD_USER}:${CMD_USER} /var/run
chown -R ${CMD_USER}:${CMD_USER} /run

chown -R root.root /run/sshd
chown -R root.root /var/run/sshd