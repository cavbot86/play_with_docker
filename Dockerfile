FROM ubuntu:bionic
LABEL maintainer=cavbot@outlook.com

ENV HOME=/root \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
    STARTUP_SCRIPT="/startup.sh" \
    ROOT_INIT_PASSWORD="" \
    SUDOER_USER="admin" \
    SUDOER_USER_INIT_PASSWORD="" \
    SUDOER_USER_EMAIL="admin@cavbot.com" \
    SSH_ID_RSA_DIR=/ssh_id_rsa

COPY rootfs/etc/apt/sources.list /etc/apt/sources.list 

RUN apt-get update \
    && apt-get install bash sudo lsof supervisor openssh-server --fix-missing -y \
    && apt-get autoremove -y --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && echo "alias ll='ls -al'" >> /etc/profile \
    && mkdir -p /init_scripts \
    && mkdir -p /startup_scripts \
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && groupadd -g 1000 ${SUDOER_USER} \
    && useradd ${SUDOER_USER} -u 1000 -s /bin/bash -g ${SUDOER_USER} \
    && echo "${SUDOER_USER} ALL=(ALL) NOPASSWD: ALL " > /etc/sudoers.d/001_${SUDOER_USER}

COPY rootfs/etc/supervisor/conf.d/ /etc/supervisor/conf.d/
COPY rootfs/entrypoint.sh /entrypoint.sh
COPY rootfs/init.sh /init.sh
COPY rootfs/init_scripts/ /init_scripts/
COPY rootfs/startup_scripts/ /startup_scripts/

RUN chmod +x /entrypoint.sh /init.sh 

USER ${SUDOER_USER}

EXPOSE 22/tcp
ENTRYPOINT [ "/entrypoint.sh" ]