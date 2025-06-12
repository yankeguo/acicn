FROM ghcr.io/yankeguo/acicn/jdk:base-250612-1040

ENV JAVA_VERSION=21
ENV GRAALVM_VERSION=21.0.2
ENV JRE_VERSION="${JAVA_VERSION}"
ENV JDK_VERSION="${JAVA_VERSION}"

RUN curl -sSL -o graalvm.tar.gz "https://github.com/graalvm/graalvm-ce-builds/releases/download/jdk-${GRAALVM_VERSION}/graalvm-community-jdk-${GRAALVM_VERSION}_linux-x64_bin.tar.gz" && \
    mkdir -p "/opt/graalvm-${JAVA_VERSION}" && \
    tar -xf graalvm.tar.gz -C "/opt/graalvm-${JAVA_VERSION}" --strip-components=1 && \
    rm -rf graalvm.tar.gz

ENV JAVA_HOME="/opt/graalvm-${JAVA_VERSION}"

ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN "${JAVA_HOME}/bin/java" -version && \
    java -version && \
    java-wrapper -version && \
    echo "JAVA_HOME: OK" && \
    as.sh --help && \
    echo "AS: OK"
