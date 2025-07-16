FROM ghcr.io/yankeguo/minit:1.16.1 AS utils-minit

FROM debian:12

ENV LANG="zh_CN.UTF-8"
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y locales locales-all tzdata ca-certificates vim curl procps net-tools unzip \
    ncat telnet socat apache2-utils tini && \
    rm -rf /var/lib/apt/lists/* && \
    TZ=Asia/Shanghai && \
    echo $TZ > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime

RUN mkdir -p /opt/bin
ENV PATH="/opt/bin:${PATH}"
COPY --from=utils-minit /minit /opt/bin/minit

ENTRYPOINT ["/opt/bin/minit"]