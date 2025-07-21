FROM ghcr.io/yankeguo/acicn/debian:12-250716-1739

ARG TARGETARCH

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

ENV JAVA_HOME="/usr/lib/jvm/temurin-${JDK_VERSION}-jdk-${TARGETARCH}"

RUN "${JAVA_HOME}/bin/java" -version && echo "JAVA_HOME: OK"

WORKDIR /opt/zookeeper

ENV ZOOKEEPER_VERSION="3.8.4"

RUN curl -sSL -o zookeeper.tar.gz "https://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz" && \
    tar -xvf zookeeper.tar.gz --strip-components=1 && \
    rm -f zookeeper.tar.gz

ENV PATH="/opt/zookeeper/bin:${PATH}"

ADD zookeeper /opt/zookeeper
ADD minit.d /etc/minit.d

####################################
# JVM Configuration
####################################

# ENV ZKJVM_OPTS=""
# ENV ZKJVM_XMS=""
# ENV ZKJVM_XMX=""

####################################
# Zookeeper Configuration
####################################

ENV ZKCFG_tickTime="2000"
ENV ZKCFG_initLimit="10"
ENV ZKCFG_syncLimit="5"
ENV ZKCFG_dataDir="/data"
ENV ZKCFG_clientPort="2181"
ENV ZKCFG_maxClientCnxns="1024"
ENV ZKCFG_autopurge__snapRetainCount="5"
ENV ZKCFG_autopurge__purgeInterval="1"

####################################
# Cluster Configuration
####################################

ENV ZKAUTOCFG_MYID="1"
# ENV ZKAUTOCFG_SERVERS zoo1:2888:3888,zoo2:2888:3888,zoo3:2888:3888