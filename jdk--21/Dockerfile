FROM ghcr.io/yankeguo/acicn/jdk:base-250717-1003

ARG TARGETARCH

ENV JAVA_VERSION=21
ENV JRE_VERSION="${JAVA_VERSION}"
ENV JDK_VERSION="${JAVA_VERSION}"

RUN apt-get update && \
    apt-get install -y "temurin-${JDK_VERSION}-jdk" && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME="/usr/lib/jvm/temurin-${JDK_VERSION}-jdk-${TARGETARCH}"

RUN "${JAVA_HOME}/bin/java" -version && \
    java -version && \
    java-wrapper -version && \
    echo "JAVA_HOME: OK" && \
    as.sh --help && \
    echo "AS: OK"
