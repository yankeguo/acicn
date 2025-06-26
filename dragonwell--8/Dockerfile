FROM ghcr.io/yankeguo/acicn/jdk:base-241118-1651

ENV JAVA_VERSION=8
ENV JRE_VERSION="${JAVA_VERSION}"
ENV JDK_VERSION="${JAVA_VERSION}"

RUN apt-get update && \
    apt-get install -y fonts-dejavu libasound2 libc6 libfontconfig1 libfreetype6 libx11-6 libxext6 libxi6 libxrender1 libxtst6 zlib1g && \
    rm -rf /var/lib/apt/lists/*

RUN curl -sSL -o "dragonwell-${JAVA_VERSION}-jdk.tar.gz" "https://dragonwell.oss-cn-shanghai.aliyuncs.com/8.25.24/Alibaba_Dragonwell_Extended_8.25.24_x64_linux.tar.gz" && \
    mkdir -p "/opt/dragonwell-${JAVA_VERSION}" && \
    tar -xzf "dragonwell-${JAVA_VERSION}-jdk.tar.gz" -C "/opt/dragonwell-${JAVA_VERSION}" --strip-components=1 && \
    rm -rf "dragonwell-${JAVA_VERSION}-jdk.tar.gz"

ENV JAVA_HOME="/opt/dragonwell-${JAVA_VERSION}"

ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN "${JAVA_HOME}/bin/java" -version && \
    java -version && \
    java-wrapper -version && \
    echo "JAVA_HOME: OK" && \
    as.sh --help && \
    echo "AS: OK"
