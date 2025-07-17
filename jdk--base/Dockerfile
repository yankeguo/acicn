FROM ghcr.io/yankeguo/acicn/assets:skywalking-agent-custom-20231214-3 AS utils-skywalking-agent-custom
FROM ghcr.io/yankeguo/acicn/debian:12-250716-1739

# Adoptium Repository
RUN apt-get update && \
    apt-get install -y apt-transport-https gpg telnet fontconfig fonts-dejavu && \
    curl -sSL 'https://packages.adoptium.net/artifactory/api/gpg/key/public' | gpg --dearmor > /etc/apt/trusted.gpg.d/adoptium.gpg && \
    echo 'deb https://packages.adoptium.net/artifactory/deb bookworm main' > /etc/apt/sources.list.d/adoptium.list && \
    rm -rf /var/lib/apt/lists/*

ADD scripts/java-wrapper /opt/bin/java-wrapper

## Arthas
ENV ARTHAS_VERSION=3.7.2

RUN mkdir -p /opt/arthas && \
    curl -sSLo arthas.zip "https://github.com/alibaba/arthas/releases/download/arthas-all-${ARTHAS_VERSION}/arthas-bin.zip" && \
    unzip -d /opt/arthas arthas.zip && \
    rm -rf arthas.zip && \
    chmod +x /opt/arthas/as.sh && \
    ln -s /opt/arthas/as.sh /opt/bin/as.sh

# JMX Prometheus JavaAgent
RUN mkdir -p /opt/lib && \
    cd /opt/lib && \
    curl -sSL -o jmx_prometheus_javaagent.jar "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.16.1/jmx_prometheus_javaagent-0.16.1.jar"
ADD etc/jmx_prometheus_javaagent /opt/etc/jmx_prometheus_javaagent

# Skywalking JavaAgent
COPY --from=utils-skywalking-agent-custom /opt/lib/skywalking-agent /opt/lib/skywalking-agent


# OpenTelemetry JavaAgent
RUN curl -sSL -o /opt/lib/opentelemetry-javaagent.jar "https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v2.10.0/opentelemetry-javaagent.jar"

# Stress
RUN curl -sSL -o /opt/EmptyJar.jar "https://github.com/yankeguo/EmptyJar/releases/download/v2.0.0/EmptyJar.jar"
ADD stress.sh /stress.sh
