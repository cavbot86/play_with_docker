#!/bin/bash
set -e

## run once
if [[ ! -f "/run_once.log" ]]; then
    echo run once!
    
    echo renew ssh keys ...
    rm -f /etc/ssh/ssh_host_rsa_key
    ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
    rm -f /etc/ssh/ssh_host_ecdsa_key
    ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
    rm -f /etc/ssh/ssh_host_ed25519_key
    ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
    
    echo init root dir ...
    if [[ ! -d "/root/.ssh" ]]; then
        mkdir -p /root/.ssh
        touch /root/.ssh/authorized_keys
        chmod 600 /root/.ssh/authorized_keys
    fi

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
        echo groupadd -g 1000 ${SUDOER_USER}
        groupadd -g 1000 ${SUDOER_USER}
        echo useradd ${SUDOER_USER} -u 1000 -s /bin/bash -g ${SUDOER_USER}
        useradd ${SUDOER_USER} -u 1000 -s /bin/bash -g ${SUDOER_USER}
        echo "echo ${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD} | chpasswd"
        echo "${SUDOER_USER}:${SUDOER_USER_INIT_PASSWORD}" | chpasswd
        mkdir -p /home/${SUDOER_USER}
        mkdir -p /home/${SUDOER_USER}/.ssh
        touch /home/${SUDOER_USER}/.ssh/authorized_keys
        chmod 600 /home/${SUDOER_USER}/.ssh/authorized_keys
        echo "${SUDOER_USER} ALL=(ALL) ALL " > /etc/sudoers.d/001_${SUDOER_USER}
        chown -R ${SUDOER_USER}:${SUDOER_USER} /home/${SUDOER_USER}
    fi

    echo "run once finished: `date`"
    echo "run once finished: `date`" > /run_once.log
fi

