FROM ghcr.io/yankeguo/acicn/debian:12-240731-1022

ENV JAVA_VERSION=17
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

WORKDIR /opt/seata

ENV SEATA_VERSION 1.7.1

RUN curl -sSL -o seata.tar.gz "https://github.com/apache/incubator-seata/releases/download/v${SEATA_VERSION}/seata-server-${SEATA_VERSION}.tar.gz" && \
    tar -xvf seata.tar.gz --strip-components=1 && \
    rm -f seata.tar.gz

ADD seata ./

ADD minit.d /etc/minit.d

####################################
# Startup Parameters
####################################

# ENV SEATA_CLASSPATH_EXTRA=""

# ENV SEATA_MEMORY_OPTS="-Xms512m -Xmx512m -Xmn256m"

# ENV SEATA_ARGS=""