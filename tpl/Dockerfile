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
    && rm -rf /var/lib/apt/lists/* \
    && echo "alias ll='ls -al'" >> /etc/profile 

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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

ENV EMAIL="cavbot@outlook.com" \
	LANG=zh_CN.UTF-8 \
	LANGUAGE=zh_CN.UTF-8 \
	LC_ALL=zh_CN.UTF-8 \
    USER=ubuntu

COPY start_app.sh /start_app.sh
COPY prepare_app.sh /prepare_app.sh
RUN chmod +x /start_app.sh /prepare_app.sh

EXPOSE 22/tcp
CMD [ "/start_app.sh" ]




FROM ubuntu:bionic
LABEL maintainer=cavbot@outlook.com

ENV HOME=/root \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
    STARTUP_SCRIPT="/startup.sh" \
    ROOT_INIT_PASSWORD="" \
    SUDOER_USER="admin" \
    SUDOER_USER_INIT_PASSWORD="" \
    SUDOER_USER_EMAIL="admin@cavbot.com"

RUN rm -f /etc/apt/sources.list
COPY sources.list /etc/apt/ 

RUN apt-get update \
    && apt-get install git bash sudo vim net-tools wget curl supervisor openssh-server --yes \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && echo "alias ll='ls -al'" >> /etc/profile \
    && mkdir -p /init_scripts \
    && mkdir -p /startup_scripts \
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY sshd.conf /etc/supervisor/conf.d/sshd.conf
COPY entrypoint.sh /entrypoint.sh
COPY init.sh /init.sh
COPY hello_world.sh /init_scripts/hello_world.sh
COPY hello_world.sh /startup_scripts/hello_world.sh

RUN chmod +x /entrypoint.sh /init.sh 

EXPOSE 22/tcp
ENTRYPOINT [ "/entrypoint.sh" ]