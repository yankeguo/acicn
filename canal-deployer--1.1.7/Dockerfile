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

WORKDIR /opt/canal-deployer

ENV CANAL_VERSION="1.1.7"

RUN curl -sSL -o canal-deployer.tar.gz "https://github.com/alibaba/canal/releases/download/canal-${CANAL_VERSION}/canal.deployer-${CANAL_VERSION}.tar.gz" && \
    tar -xvf canal-deployer.tar.gz && \
    rm -f canal-deployer.tar.gz

ADD canal-deployer/ ./
ADD minit.d/ /etc/minit.d/

####################################
# Startup Parameters
####################################

# ENV CANAL_MEMORY_OPTS="-Xms512m -Xmx512m -Xmn256m"

####################################
# Canal Properties
####################################

# ENV CANAL_CONF_canal.instance....
