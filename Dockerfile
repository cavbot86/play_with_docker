FROM cavbot/ubuntu_base_flat:latest
LABEL maintainer=cavbot@outlook.com

VOLUME [ "/data" ]


RUN apt-get update \
    && apt-get install curl --yes \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* 

EXPOSE 22/tcp
CMD [ "bash" ]
