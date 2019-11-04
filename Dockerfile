FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

ENV WORK_BASE=/home/q \
    APP_HOME=/home/q/app \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" 

RUN sudo mkdir -p ${WORK_BASE} \
    && sudo mkdir ${APP_HOME} \
    && sudo chown -R ${SUDOER_USER}.${SUDOER_USER} ${WORK_BASE}

WORKDIR ${WORK_BASE}/jdk
RUN wget https://cdn.azul.com/zulu/bin/zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && tar zxvf zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && rm -f zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && ln -s "`ls`" current \
    && echo 'export JAVA_HOME=${WORK_BASE}/jdk/current' >> /home/${WORK_BASE}/.bashrc \
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/${WORK_BASE}/.bashrc

WORKDIR ${APP_HOME}
COPY rootfs/start_app.sh /start_app.sh
COPY rootfs/prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
