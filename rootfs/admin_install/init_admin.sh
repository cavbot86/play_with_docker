#!/bin/bash
set -e

## run once
if [[ ! -f "/run_once.log" ]]; then
    echo run once!

    echo renew ssh keys ...
    sudo rm -f /etc/ssh/ssh_host_rsa_key
    sudo ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
    sudo rm -f /etc/ssh/ssh_host_ecdsa_key
    sudo ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
    sudo rm -f /etc/ssh/ssh_host_ed25519_key
    sudo ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
    
    echo init root dir ...
    sudo rm -rf /root/.ssh
    if [[ ! -d "/root/.ssh" ]]; then
        sudo mkdir -p /root/.ssh
        sudo touch /root/.ssh/authorized_keys
        sudo chmod 600 /root/.ssh/authorized_keys
    fi

    sudo ssh-keygen -f /root/.ssh/id_rsa -N "" -t rsa -b 4096 -C "${EMAIL}"

    echo init /var/run/sshd ...
    if [[ ! -d "/var/run/sshd" ]]; then
        sudo mkdir -p /var/run/sshd
    fi
    echo ""
    echo ""

    sudo mkdir /run_once_admin
    sudo chown -R ${SUDOER_USER}:${SUDOER_USER} /run_once_admin
    
    echo "init root password ..."
    if [[ -z "${ROOT_INIT_PASSWORD}" ]]; then
        ROOT_INIT_PASSWORD=`openssl rand -base64 16 | head -c10`
    fi
    echo "################################################################################################"
    echo "#"
    echo "# The root password is ${ROOT_INIT_PASSWORD} , you can find it in /run_once_admin/init_root_password"
    echo "#"
    echo "################################################################################################"
    echo ${ROOT_INIT_PASSWORD} > /run_once_admin/init_root_password
    echo "root:${ROOT_INIT_PASSWORD}" | sudo chpasswd
    echo ""
    echo ""
    
    if [[ -n "${SUDOER_USER}" ]]; then
        echo "init sudoer user..."
        if [[ -z "${SUDOER_USER_INIT_PASSWORD}" ]]; then
            SUDOER_USER_INIT_PASSWORD=`openssl rand -base64 16 | head -c10`
        fi
        echo "################################################################################################"
        echo "#"
        echo "# The sudoer password is ${SUDOER_USER_INIT_PASSWORD} , you can find it in /run_once_admin/init_sudoer_password"
        echo "#"
        echo "################################################################################################"
        echo ""
        echo ""
        echo ${SUDOER_USER_INIT_PASSWORD} > /run_once_admin/init_sudoer_password
        echo "echo ${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD} | chpasswd"
        echo "${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD}" | sudo chpasswd
        sudo mkdir -p /home/${SUDOER_USER}
        sudo chown -R ${SUDOER_USER}:${SUDOER_USER} /home/${SUDOER_USER}
        sudo chown -R ${SUDOER_USER}:${SUDOER_USER} /var/log/supervisor
        
        mkdir -p /home/${SUDOER_USER}/.ssh
        touch /home/${SUDOER_USER}/.ssh/authorized_keys
        chmod 600 /home/${SUDOER_USER}/.ssh/authorized_keys
        ssh-keygen -f /home/${SUDOER_USER}/.ssh/id_rsa -N "" -t rsa -b 4096 -C "${EMAIL}"
        chmod 600 /home/${SUDOER_USER}/.ssh/id_rsa
        echo "alias ll='ls -al'" >> /home/${SUDOER_USER}/.bashrc
    fi

    echo "start run init scripts..."
    sudo chmod +x /init_scripts/*.sh
    for var in $(ls /init_scripts/*.sh)
    do
        echo "$var"
        $var
    done
    echo "run init scripts finished."

    echo "run once finished: `date`"
    echo "run once finished: `date`" > /run_once.log
fi

