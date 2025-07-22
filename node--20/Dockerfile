FROM ghcr.io/yankeguo/acicn/debian:12-250716-1739

ARG TARGETARCH

ENV NODE_VERSION_MAJOR=20
ENV NODE_VERSION=20.19.4

RUN if [ "$TARGETARCH" = "amd64" ]; then \
        curl -sSLo node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz"; \
    else \
        curl -sSLo node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-arm64.tar.gz"; \
    fi && \
    mkdir -p "/opt/node-${NODE_VERSION_MAJOR}" && \
    tar -xf node.tar.xz -C "/opt/node-${NODE_VERSION_MAJOR}" --strip-components=1 && \
    rm -f node.tar.xz

ENV PATH="/opt/node-${NODE_VERSION_MAJOR}/bin:${PATH}"

RUN npm install -g --unsafe-perm=true yarn "cnpm@latest" "pnpm@latest-10" --registry "https://registry.npmmirror.com"

ADD stress.sh /stress.sh
