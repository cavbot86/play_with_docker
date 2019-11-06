FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

# VOLUME [ "/data" ]

ENV WORKSPACE=/home/c \
    APP_ROOT=/home/c/app \
    JDK_ROOT=/home/c/jdk \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com"

COPY rootfs/home/c/ /home/c/
COPY rootfs/start_app.sh /start_app.sh
COPY rootfs/prepare_app.sh /prepare_app.sh
RUN sudo chmod +x /start_app.sh /prepare_app.sh /home/c/install/*.sh /home/c/app/*.sh \
    && /home/c/install/app_install.sh

WORKDIR ${WORKSPACE}
ENV CMD_USER=${SUDOER_USER} \
    HOME=/home/${SUDOER_USER} \
    HOME_INIT=${ADMIN_RUN}/home/${SUDOER_USER}
RUN mkdir -p ${HOME_INIT} \
    && scp -r ${HOME}/ ${ADMIN_RUN}/home/ \
    && chown -R ${SUDOER_USER}.${SUDOER_USER} ${HOME_INIT}

EXPOSE 22/tcp
CMD [ "/home/c/startup/start_app.sh" ]
