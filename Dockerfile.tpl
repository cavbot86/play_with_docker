FROM cavbot/ubuntu_base_flat:latest
LABEL maintainer=cavbot@outlook.com

VOLUME [ "/data" ]

ENV HOME=/root \
    PREPARE_SLEEP=120 \
    EMAIL="cavbot@outlook.com"

RUN apt-get update \
    && apt-get install curl --yes \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* 

RUN mkdir /root/tmp \
    && cd /root/tmp \
    && wget https://github.com/cavbot86/tools/raw/master/chrome/chrome.zip.001 \
    && wget https://github.com/cavbot86/tools/raw/master/chrome/chrome.zip.002 \
    && wget https://github.com/cavbot86/tools/raw/master/chrome/chrome.zip.003 \
    && cat chrome.zip.* > chrome.zip \
    && unzip chrome.zip \
    && dpkg -i 'chrome/google-chrome-stable_current_amd64.deb' \
    && rm -rf /root/tmp \
    && sed -ri "s/google-chrome-stable/google-chrome-stable --user-data-dir=\/home\/${USER}\/chrome-data/g" /usr/share/applications/google-chrome.desktop


COPY start_app.sh /start_app.sh
COPY prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]
