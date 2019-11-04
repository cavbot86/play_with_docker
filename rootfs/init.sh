#!/bin/bash
set -e

## run once
if [[ ! -f "/run_once.log" ]]; then
    echo run once!

    echo "alias ll='ls -al'" >> /root/.bashrc
    
    echo renew ssh keys ...
    rm -f /etc/ssh/ssh_host_rsa_key
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
    rm -f /etc/ssh/ssh_host_ecdsa_key
    ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
    rm -f /etc/ssh/ssh_host_ed25519_key
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
    
    echo init root dir ...
    rm -rf /root/.ssh
    if [[ ! -d "/root/.ssh" ]]; then
        mkdir -p /root/.ssh
        touch /root/.ssh/authorized_keys
        chmod 600 /root/.ssh/authorized_keys
    fi

    ssh-keygen -f /root/.ssh/id_rsa -N "" -t rsa -b 4096 -C "${EMAIL}"

    echo init /var/run/sshd ...
    if [[ ! -d "/var/run/sshd" ]]; then
        mkdir -p /var/run/sshd
    fi
    echo ""
    echo ""
    
    echo "init root password ..."
    if [[ -z "${ROOT_INIT_PASSWORD}" ]]; then
        ROOT_INIT_PASSWORD=`openssl rand -base64 16 | head -c10`
    fi
    echo "################################################################################################"
    echo "#"
    echo "# The root password is ${ROOT_INIT_PASSWORD} , you can find it in /root/init_root_password"
    echo "#"
    echo "################################################################################################"
    echo ${ROOT_INIT_PASSWORD} > /root/init_root_password
    echo "root:${ROOT_INIT_PASSWORD}" | chpasswd
    echo ""
    echo ""
    
    if [[ -n "${SUDOER_USER}" ]]; then
        echo "init sudoer user..."
        if [[ -z "${SUDOER_USER_INIT_PASSWORD}" ]]; then
            SUDOER_USER_INIT_PASSWORD=`openssl rand -base64 16 | head -c10`
        fi
        echo "################################################################################################"
        echo "#"
        echo "# The sudoer password is ${SUDOER_USER_INIT_PASSWORD} , you can find it in /root/init_sudoer_password"
        echo "#"
        echo "################################################################################################"
        echo ""
        echo ""
        echo ${SUDOER_USER_INIT_PASSWORD} > /root/init_sudoer_password
        echo "echo ${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD} | chpasswd"
        echo "${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD}" | chpasswd
        mkdir -p /home/${SUDOER_USER}
        mkdir -p /home/${SUDOER_USER}/.ssh
        touch /home/${SUDOER_USER}/.ssh/authorized_keys
        chmod 600 /home/${SUDOER_USER}/.ssh/authorized_keys
        ssh-keygen -f /home/${SUDOER_USER}/.ssh/id_rsa -N "" -t rsa -b 4096 -C "${EMAIL}"
        chmod 600 /home/${SUDOER_USER}/.ssh/id_rsa
        chown -R ${SUDOER_USER}:${SUDOER_USER} /home/${SUDOER_USER}
    fi

    echo "start run init scripts..."
    for var in $(ls /init_scripts/*.sh)
    do
        echo bash "$var"
        bash "$var"
    done
    echo "run init scripts finished."

    echo "run once finished: `date`"
    echo "run once finished: `date`" > /run_once.log
fi

