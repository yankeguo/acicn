FROM ghcr.io/yankeguo/minit:1.14.0-rc1 AS utils-minit

FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y locales locales-all tzdata ca-certificates vim curl procps net-tools unzip \
    ncat telnet socat apache2-utils tini && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/bin
ENV PATH="/opt/bin:${PATH}"
COPY --from=utils-minit /minit /opt/bin/minit
ENV MINIT_LOG_DIR=none

ENTRYPOINT ["/opt/bin/minit"]