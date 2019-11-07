#!/bin/bash
set -e

echo init root dir ...
rm -rf /root/.ssh
if [[ ! -d "/root/.ssh" ]]; then
    mkdir -p /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi
echo "alias ll='ls -al'" >> /root/.bashrc

echo init /var/run/sshd ...
if [[ ! -d "/var/run/sshd" ]]; then
    mkdir -p /var/run/sshd
fi

mkdir ${ADMIN_RUN}

# init admin user
groupadd -g 1000 ${SUDOER_USER} 
useradd ${SUDOER_USER} -u 1000 -s /bin/bash -g ${SUDOER_USER} 
echo "${SUDOER_USER} ALL=(ALL) ALL " > /etc/sudoers.d/001_${SUDOER_USER}

mkdir -p /home/${SUDOER_USER}
mkdir -p /home/${SUDOER_USER}/.ssh
touch /home/${SUDOER_USER}/.ssh/authorized_keys
chmod 600 /home/${SUDOER_USER}/.ssh/authorized_keys
echo "alias ll='ls -al'" >> /home/${SUDOER_USER}/.bashrc
echo "alias ll='ls -al'" >> /etc/profile
