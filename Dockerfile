FROM cavbot/ubuntu_base_flat:latest
LABEL maintainer=cavbot@outlook.com

ENV HOME=/root \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" \
    JDK_ROOT=/usr/local/jdk \
    JDK_VERSION=jdk1.8.0_231 \
    JAVA_HOME=${JDK_ROOT}/${JDK_VERSION} \
    PATH=${JAVA_HOME}/bin:${PATH}


ADD jdk-8u231-linux-x64.tar.gz ${JDK_ROOT}/

COPY start_app.sh /start_app.sh
COPY prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
