#!/bin/bash
set -e
# apt-get update
# apt-get install curl -y
# apt-get autoremove -y --purge
# apt-get clean
# rm -rf /tmp/*
# rm -rf /var/tmp/*
# rm -rf /var/lib/apt/lists/* 

mkdir -p ${APP_ROOT}
chown -R ${SUDOER_USER}.${SUDOER_USER} ${APP_ROOT}
mkdir -p ${JDK_ROOT}
cd ${JDK_ROOT}
wget https://cdn.azul.com/zulu/bin/zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz 
tar zxvf zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz 
rm -f zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz 
ln -s "`ls`" current
echo "export JAVA_HOME=${JDK_ROOT}/current" >> /root/.bashrc 
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /root/.bashrc

echo "export JAVA_HOME=${JDK_ROOT}/current" >> /home/${SUDOER_USER}/.bashrc 
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/${SUDOER_USER}/.bashrc

