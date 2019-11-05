FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

ENV WORK_SPACE=/home/c \
    APP_ROOT=/home/c/app \
    JDK_ROOT=/home/c/jdk \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" 
USER root
RUN mkdir -p ${WORK_SPACE} \
    && mkdir -p ${APP_ROOT} \
    && mkdir -p ${JDK_ROOT} \
    && chown -R ${SUDOER_USER}.${SUDOER_USER} ${WORK_SPACE} 

USER ${SUDOER_USER}
WORKDIR ${JDK_ROOT}
RUN wget https://cdn.azul.com/zulu/bin/zulu11.35.13-ca-jdk11.0.5-linux_x64.tar.gz \
    && tar zxvf zulu11.35.13-ca-jdk11.0.5-linux_x64.tar.gz \
    && rm -f zulu11.35.13-ca-jdk11.0.5-linux_x64.tar.gz \
    && ln -s "`ls`" current \
    && echo "export JAVA_HOME=${JDK_ROOT}/current" >> /home/${SUDOER_USER}/.bashrc \
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /home/${SUDOER_USER}/.bashrc

WORKDIR ${APP_ROOT}
COPY rootfs/start_app.sh /start_app.sh
COPY rootfs/prepare_app.sh /prepare_app.sh
RUN sudo chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
