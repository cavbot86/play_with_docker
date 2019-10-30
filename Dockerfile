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

RUN rm -f /etc/apt/sources.list
COPY sources.list /etc/apt/ 

RUN apt-get update \
    && apt-get install bash sudo supervisor openssh-server --fix-missing --yes \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && echo "alias ll='ls -al'" >> /etc/profile \
    && mkdir -p /init_scripts \
    && mkdir -p /startup_scripts \
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sshd.conf /etc/supervisor/conf.d/sshd.conf
COPY entrypoint.sh /entrypoint.sh
COPY init.sh /init.sh
COPY hello_world.sh /init_scripts/hello_world.sh
COPY hello_world.sh /startup_scripts/hello_world.sh

RUN chmod +x /entrypoint.sh /init.sh 

EXPOSE 22/tcp
ENTRYPOINT [ "/entrypoint.sh" ]