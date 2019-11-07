FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

# VOLUME [ "/data" ]

ENV WORKSPACE=/home/c \
    APP_ROOT=/home/c/app \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com"

COPY rootfs/home/c/install/ ${WORKSPACE}/install/
RUN chmod +x ${WORKSPACE}/install/*.sh \
    && ${WORKSPACE}/install/app_install.sh

COPY rootfs/start_app.sh /start_app.sh
COPY rootfs/prepare_app.sh /prepare_app.sh
COPY rootfs/home/c/app/ ${APP_ROOT}/

WORKDIR ${WORKSPACE}
ENV CMD_USER=${SUDOER_USER} \
    HOME=/home/${SUDOER_USER} \
    HOME_INIT=${ADMIN_RUN}/home/${SUDOER_USER}
COPY rootfs/admin_install/init_permission.sh /admin_install/init_permission.sh
RUN mkdir -p ${HOME_INIT} \
    && scp -r ${HOME}/ ${ADMIN_RUN}/home/ \
    && chmod +x /start_app.sh /prepare_app.sh ${APP_ROOT}/*.sh \
        /admin_install/init_permission.sh \
    && /admin_install/init_permission.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
