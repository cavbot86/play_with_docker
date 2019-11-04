#!/bin/bash
set -e

apt-get update 
apt-get install bash sudo lsof supervisor openssh-server --fix-missing --yes
apt-get autoremove --yes --purge 
apt-get clean 
rm -rf /tmp/* 
rm -rf /var/tmp/* 
rm -rf /var/lib/apt/lists/* 

echo "alias ll='ls -al'" >> /etc/profile

mkdir -p /init_scripts 
mkdir -p /startup_scripts 

sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config 
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config 

# init admin user
groupadd -g 1000 ${SUDOER_USER} 
useradd ${SUDOER_USER} -u 1000 -s /bin/bash -g ${SUDOER_USER} 
echo "${SUDOER_USER} ALL=(ALL) NOPASSWD: ALL " > /etc/sudoers.d/001_${SUDOER_USER}

