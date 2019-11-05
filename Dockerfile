FROM ubuntu:bionic
LABEL maintainer=cavbot@outlook.com

ENV LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
    ROOT_INIT_PASSWORD="" \
    SUDOER_USER="admin" \
    SUDOER_USER_INIT_PASSWORD="" \
    SUDOER_USER_EMAIL="admin@cavbot.com" \
    SSH_ID_RSA_DIR=/ssh_id_rsa \
    ADMIN_RUN_DATA=/admin_run_data \
    WORKSPACE=/home/c

COPY rootfs/etc/apt/sources.list /etc/apt/sources.list

COPY rootfs/admin_install/ /admin_install/
COPY rootfs/admin_startup/ /admin_startup/
COPY rootfs/etc/supervisor/conf.d/ /etc/supervisor/conf.d/
COPY rootfs/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh /admin_install/* /admin_startup/* /bin/tini \
    && /admin_install/init_common.sh \
    && /admin_install/init_admin.sh \
    && mkdir ${WORKSPACE} \
    && chown -R ${SUDOER_USER}:${SUDOER_USER} ${WORKSPACE}

WORKDIR ${WORKSPACE}

EXPOSE 22/tcp
ENTRYPOINT [ "/entrypoint.sh" ]