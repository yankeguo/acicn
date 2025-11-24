FROM ghcr.io/yankeguo/acicn/debian:12-250716-1739

ARG TARGETARCH

ENV NODE_VERSION=14
ENV ALINODE_VERSION=6.8.1

RUN if [ "$TARGETARCH" = "amd64" ]; then \
    curl -sSLo alinode.tar.gz "https://registry.npmmirror.com/-/binary/alinode/v${ALINODE_VERSION}/alinode-v${ALINODE_VERSION}-linux-x64.tar.gz"; \
    else \
    curl -sSLo alinode.tar.gz "https://registry.npmmirror.com/-/binary/alinode/v${ALINODE_VERSION}/alinode-v${ALINODE_VERSION}-linux-arm64.tar.gz"; \
    fi && \
    mkdir -p "/opt/node-${NODE_VERSION}" && \
    tar -xf alinode.tar.gz -C "/opt/node-${NODE_VERSION}" --strip-components=1 && \
    rm -f alinode.tar.gz

ENV PATH="/opt/node-${NODE_VERSION}/bin:${PATH}"

ENV NODE_LOG_DIR=/var/log/agenthub

RUN npm config set registry "https://registry.npmmirror.com" && \
    npm install -g cnpm @alicloud/agenthub && \
    npm cache clean --force && \
    mkdir -p "$NODE_LOG_DIR"

ENV ENABLE_NODE_LOG=YES

ADD agenthub /opt/agenthub

ENV FILEBEAT_VERSION=7.12.1

RUN if [ "$TARGETARCH" = "amd64" ]; then \
    curl -sSLo filebeat.tar.gz "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz"; \
    else \
    curl -sSLo filebeat.tar.gz "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-arm64.tar.gz"; \
    fi && \
    mkdir -p /opt/filebeat && \
    tar -xf filebeat.tar.gz -C /opt/filebeat --strip-components=1 && \
    rm -f filebeat.tar.gz

ADD filebeat.yml /opt/filebeat/filebeat.yml

ADD minit.d /etc/minit.d
