FROM        cm2network/steamcmd:root

LABEL       MAINTAINER="https://github.com/kumotaicho/"

ARG         ARK_TOOLS_VERSION="1.6.61a"
ARG         IMAGE_VERSION="dev"

ENV         IMAGE_VERSION="${IMAGE_VERSION}" \
            SESSION_NAME="Dockerized ARK Server by github.com/kumotaicho" \
            SERVER_MAP1="TheIsland" \
            SERVER_MAP2="" \
            SERVER_MAP3="" \
            SERVER_MAP4="" \
            SERVER_MAP5="" \
            SERVER_PASSWORD="YouShallNotPass" \
            ADMIN_PASSWORD="Th155houldD3f1n3tlyB3Chang3d" \
            MAX_PLAYERS="20" \
            GAME_MOD_IDS="" \
            UPDATE_ON_START="false" \
            BACKUP_ON_STOP="false" \
            PRE_UPDATE_BACKUP="true" \
            WARN_ON_STOP="true" \
            ARK_TOOLS_VERSION="${ARK_TOOLS_VERSION}" \
            ARK_SERVER_VOLUME="/app" \
            TEMPLATE_DIRECTORY="/conf.d" \
            GAME_CLIENT_PORT_MAP1="27011" \
            UDP_SOCKET_PORT_MAP1="27012" \
            SERVER_LIST_PORT_MAP1="27013" \
            RCON_PORT_MAP1="27014" \
            GAME_CLIENT_PORT_MAP2="27021" \
            UDP_SOCKET_PORT_MAP2="27022" \
            SERVER_LIST_PORT_MAP2="27023" \
            RCON_PORT_MAP2="27024" \
            GAME_CLIENT_PORT_MAP3="27031" \
            UDP_SOCKET_PORT_MAP3="27032" \
            SERVER_LIST_PORT_MAP3="27033" \
            RCON_PORT_MAP3="27034" \
            GAME_CLIENT_PORT_MAP4="27041" \
            UDP_SOCKET_PORT_MAP4="27042" \
            SERVER_LIST_PORT_MAP4="27043" \
            RCON_PORT_MAP4="27044" \
            GAME_CLIENT_PORT_MAP5="27051" \
            UDP_SOCKET_PORT_MAP5="27052" \
            SERVER_LIST_PORT_MAP5="27053" \
            RCON_PORT_MAP5="27054" \
            STEAM_HOME="/home/${USER}" \
            STEAM_USER="${USER}" \
            STEAM_LOGIN="anonymous"

ENV         ARK_TOOLS_DIR="${ARK_SERVER_VOLUME}/arkmanager"

RUN         set -x && \
            apt-get update && \
            apt-get install -y  perl-modules \
                                curl \
                                lsof \
                                libc6-i386 \
                                lib32gcc-s1 \
                                bzip2 \
                                gosu \
                                cron \
            && \
            curl -L "https://github.com/arkmanager/ark-server-tools/archive/v${ARK_TOOLS_VERSION}.tar.gz" \
                | tar -xvzf - -C /tmp/ && \
            bash -c "cd /tmp/ark-server-tools-${ARK_TOOLS_VERSION}/tools && bash -x install.sh ${USER}" && \
            ln -s /usr/local/bin/arkmanager /usr/bin/arkmanager && \
            install -d -o ${USER} ${ARK_SERVER_VOLUME} && \
            su ${USER} -c "bash -x ${STEAMCMDDIR}/steamcmd.sh +login anonymous +quit" && \
            apt-get -qq autoclean && apt-get -qq autoremove && apt-get -qq clean && \
            rm -rf /tmp/* /var/cache/*

COPY        bin/    /
COPY        conf.d  ${TEMPLATE_DIRECTORY}

EXPOSE      ${GAME_CLIENT_PORT_MAP1}/udp \
            ${UDP_SOCKET_PORT_MAP1}/udp \
            ${SERVER_LIST_PORT_MAP1}/udp \
            ${RCON_PORT_MAP1}/tcp \
            ${GAME_CLIENT_PORT_MAP2}/udp \
            ${UDP_SOCKET_PORT_MAP2}/udp \
            ${SERVER_LIST_PORT_MAP2}/udp \
            ${RCON_PORT_MAP2}/tcp \
            ${GAME_CLIENT_PORT_MAP3}/udp \
            ${UDP_SOCKET_PORT_MAP3}/udp \
            ${SERVER_LIST_PORT_MAP3}/udp \
            ${RCON_PORT_MAP3}/tcp \
            ${GAME_CLIENT_PORT_MAP4}/udp \
            ${UDP_SOCKET_PORT_MAP4}/udp \
            ${SERVER_LIST_PORT_MAP4}/udp \
            ${RCON_PORT_MAP4}/tcp \
            ${GAME_CLIENT_PORT_MAP5}/udp \
            ${UDP_SOCKET_PORT_MAP5}/udp \
            ${SERVER_LIST_PORT_MAP5}/udp \
            ${RCON_PORT_MAP5}/tcp

VOLUME      ["${ARK_SERVER_VOLUME}"]
WORKDIR     ${ARK_SERVER_VOLUME}

ENTRYPOINT  ["/docker-entrypoint.sh"]
CMD         []