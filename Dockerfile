FROM ubuntu:bionic
LABEL maintainer=cavbot@outlook.com

ENV LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai \
    ROOT_INIT_PASSWORD="" \
    SUDOER_USER="admin" \
    SUDOER_USER_INIT_PASSWORD="" \
    SUDOER_USER_EMAIL="admin@cavbot.com" \
    SSH_ID_RSA_DIR=/ssh_id_rsa \
    ADMIN_RUN=/admin_run \
    WORKSPACE=/home/c

COPY rootfs/etc/apt/sources.list /etc/apt/sources.list

COPY rootfs/admin_install/ /admin_install/
COPY rootfs/admin_startup/ /admin_startup/
COPY rootfs/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh /admin_install/* /admin_startup/* \
    && /admin_install/init_common.sh \
    && /admin_install/init_admin.sh \
    && mkdir ${WORKSPACE} 


ENV CMD_USER=${SUDOER_USER} \
    HOME=/home/${SUDOER_USER} \
    HOME_INIT=${ADMIN_RUN}/home/${SUDOER_USER}
COPY rootfs/admin_install/init_permission.sh /admin_install/init_permission.sh
RUN mkdir -p ${HOME_INIT} \
    && scp -r ${HOME}/ ${ADMIN_RUN}/home/ \
    && chmod +x /admin_install/init_permission.sh \
    && /admin_install/init_permission.sh

WORKDIR ${WORKSPACE}
EXPOSE 22/tcp
ENTRYPOINT [ "/entrypoint.sh" ]