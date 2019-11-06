#!/bin/bash
set -e

chown -R ${SUDOER_USER}:${SUDOER_USER} ${ADMIN_RUN}
chown -R ${SUDOER_USER}:${SUDOER_USER} /home/${SUDOER_USER}
chown -R ${SUDOER_USER}:${SUDOER_USER} /var/log
chown -R ${SUDOER_USER}:${SUDOER_USER} /var/run
chown -R ${SUDOER_USER}:${SUDOER_USER} /run
chown -R root.root /run/sshd
chown -R root.root /var/run/sshd
chown -R ${SUDOER_USER}.${SUDOER_USER} ${HOME_INIT} 
chown -R ${SUDOER_USER}.${SUDOER_USER} /var/log/supervisor