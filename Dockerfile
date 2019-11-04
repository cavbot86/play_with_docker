FROM ubuntu:bionic
LABEL maintainer=cavbot@outlook.com

ENV LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
    STARTUP_SCRIPT="/startup.sh" \
    ROOT_INIT_PASSWORD="" \
    SUDOER_USER="admin" \
    SUDOER_USER_INIT_PASSWORD="" \
    SUDOER_USER_EMAIL="admin@cavbot.com" \
    SSH_ID_RSA_DIR=/ssh_id_rsa \
    ADMIN_RUN_DATA=/admin_run_data

COPY rootfs/etc/apt/sources.list /etc/apt/sources.list

COPY rootfs/admin_install/ /admin_install/
COPY rootfs/admin_startup/ /admin_startup/
COPY rootfs/etc/supervisor/conf.d/ /etc/supervisor/conf.d/
COPY rootfs/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh /admin_install/* /admin_startup/* \
    && /admin_install/init_common.sh \
    && /admin_install/init_admin.sh

ENV HOME=/home/${SUDOER_USER} 
USER ${SUDOER_USER}
WORKDIR /home/${SUDOER_USER} 

EXPOSE 22/tcp
ENTRYPOINT [ "/entrypoint.sh" ]