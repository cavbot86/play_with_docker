FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

COPY rootfs/admin_install/init_supervisor.sh /admin_install/init_supervisor.sh
COPY rootfs/etc/supervisor/conf.d/ /etc/supervisor/conf.d/
COPY rootfs/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh /admin_install/*.sh \
    && /admin_install/init_supervisor.sh 

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