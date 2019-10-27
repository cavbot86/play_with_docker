FROM cavbot/ubuntu_base_flat:latest
LABEL maintainer=cavbot@outlook.com

VOLUME [ "/data" ]

ENV HOME=/root \
    PREPARE_SLEEP=5 \
    EMAIL="cavbot@outlook.com"

RUN apt-get update \
    && apt-get install curl --yes \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* 
ADD jdk-8u231-linux-x64.tar.gz /usr/local/jdk/

COPY start_app.sh /start_app.sh
COPY prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
