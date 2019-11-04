FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

ENV WORK_BASE=/home/q \
    APP_HOME=${WORK_BASE}/app \
    JDK_HOME=${WORK_BASE}/jdk \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" 

RUN sudo mkdir -p ${JDK_HOME} \
    && sudo mkdir -p ${APP_HOME} \
    && sudo chown -R ${SUDOER_USER}.${SUDOER_USER} ${WORK_BASE}

WORKDIR ${JDK_HOME}
RUN wget https://cdn.azul.com/zulu/bin/zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && tar zxvf zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && rm -f zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && ln -s "`ls`" current \
    && echo 'export JAVA_HOME=${JDK_HOME}/current' >> /home/${SUDOER_USER}/.bashrc \
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/${SUDOER_USER}/.bashrc

WORKDIR ${APP_HOME}
COPY rootfs/start_app.sh /start_app.sh
COPY rootfs/prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
