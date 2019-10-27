FROM cavbot/ubuntu_base_flat:latest
LABEL maintainer=cavbot@outlook.com

ENV HOME=/root \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com" 


ADD jdk-11.0.5_linux-x64_bin.tar.gz /usr/local/jdk/

WORKDIR /usr/local/jdk
RUN ln -s "`ls`" current \
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
