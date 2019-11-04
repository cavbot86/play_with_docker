FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

ENV WORK_SPACE=/home/q \
    APP_ROOT=/home/q/app \
    JDK_ROOT=/home/q/jdk \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" 

RUN sudo mkdir -p ${WORK_SPACE} \
    && sudo mkdir -p ${APP_ROOT} \
    && sudo mkdir -p ${JDK_ROOT} \
    && sudo chown -R ${SUDOER_USER}.${SUDOER_USER} ${WORK_SPACE} \
    && echo "sudo chown -R ${SUDOER_USER}.${SUDOER_USER} ${WORK_SPACE}"

WORKDIR ${JDK_ROOT}
RUN wget https://cdn.azul.com/zulu/bin/zulu11.35.13-ca-jdk11.0.5-linux_x64.tar.gz \
    && tar zxvf zulu11.35.13-ca-jdk11.0.5-linux_x64.tar.gz \
    && rm -f zulu11.35.13-ca-jdk11.0.5-linux_x64.tar.gz \
    && ln -s "`ls`" current \
    && echo "export JAVA_HOME=${JDK_HOME}/current" >> /home/${SUDOER_USER}/.bashrc \
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/${SUDOER_USER}/.bashrc

WORKDIR ${APP_ROOT}
COPY rootfs/start_app.sh /start_app.sh
COPY rootfs/prepare_app.sh /prepare_app.sh
RUN sudo chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
