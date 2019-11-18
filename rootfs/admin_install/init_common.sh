#!/bin/bash
set -e

ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get update 
apt-get install bash sudo lsof openssh-server tzdata unzip --fix-missing --yes
apt-get autoremove --yes --purge 
apt-get clean 
rm -rf /tmp/* 
rm -rf /var/tmp/* 
rm -rf /var/lib/apt/lists/* 

sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config 
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config 


