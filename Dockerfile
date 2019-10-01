FROM cavbot/ubuntu_base_flat:latest
LABEL maintainer=cavbot@outlook.com

VOLUME [ "/data" ]

ENV HOME=/root \
    EMAIL="cavbot@outlook.com"

RUN apt-get update \
    && apt-get install curl --yes \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* 

COPY start_app.sh /start_app.sh
RUN chmod +x /start_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
