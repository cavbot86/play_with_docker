FROM cavbot/ubuntu-base-flat:latest
LABEL maintainer=cavbot@outlook.com

ENV HOME=/root \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" 

RUN mkdir -p /usr/local/jdk

WORKDIR /usr/local/jdk
RUN wget https://cdn.azul.com/zulu/bin/zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && tar zxvf zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && rm -f zulu8.42.0.21-ca-jdk8.0.232-linux_x64.tar.gz \
    && ln -s "`ls`" current \
    && echo "export JAVA_HOME=/usr/local/jdk/current" >> /etc/profile \ 
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile \
    && echo 'export JAVA_HOME=/usr/local/jdk/current' >> /root/.bashrc \
    && echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /root/.bashrc

WORKDIR /
COPY start_app.sh /start_app.sh
COPY prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
