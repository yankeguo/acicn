FROM ghcr.io/yankeguo/acicn/debian:12-240731-1022

ENV JAVA_VERSION=11
ENV JRE_VERSION="${JAVA_VERSION}"
ENV JDK_VERSION="${JAVA_VERSION}"

RUN apt-get update && \
    apt-get install -y apt-transport-https gpg telnet && \
    curl -sSL 'https://packages.adoptium.net/artifactory/api/gpg/key/public' | gpg --dearmor > /etc/apt/trusted.gpg.d/adoptium.gpg && \
    echo 'deb https://packages.adoptium.net/artifactory/deb bookworm main' > /etc/apt/sources.list.d/adoptium.list && \
    apt-get update && \
    apt-get install -y "temurin-${JDK_VERSION}-jdk" && \
    rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH="/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/lib/x86_64-linux-gnu"
ENV JAVA_HOME="/usr/lib/jvm/temurin-${JDK_VERSION}-jdk-amd64"

RUN "${JAVA_HOME}/bin/java" -version && echo "JAVA_HOME: OK"

WORKDIR /opt/canal-admin

ENV CANAL_VERSION="1.1.7"

RUN curl -sSL -o canal-admin.tar.gz "https://github.com/alibaba/canal/releases/download/canal-${CANAL_VERSION}/canal.admin-${CANAL_VERSION}.tar.gz" && \
    tar -xvf canal-admin.tar.gz && \
    rm -f canal-admin.tar.gz && \
    rm -f conf/application.yml

ADD canal-admin/ ./
ADD minit.d/ /etc/minit.d/

####################################
# Startup Parameters
####################################

# ENV CANAL_MEMORY_OPTS="-Xms512m -Xmx512m -Xmn256m"

####################################
# Application Properties
####################################

ENV CANAL_CONF_server.port="8089"
ENV CANAL_CONF_spring.jackson.data-format="yyyy-MM-dd HH:mm:ss"
ENV CANAL_CONF_spring.jackson.time-zone="GMT+8"
ENV CANAL_CONF_spring.datasource.url=""
ENV CANAL_CONF_spring.datasource.username=""
ENV CANAL_CONF_spring.datasource.password=""
ENV CANAL_CONF_spring.datasource.hikari.maximum-pool-size="30"
ENV CANAL_CONF_spring.datasource.hikari.minimum-idle="1"
ENV CANAL_CONF_canal.adminUser="admin"
ENV CANAL_CONF_canal.adminPasswd="admin"