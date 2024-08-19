FROM ghcr.io/yankeguo/acicn/debian:12-240731-1022

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip python3-venv python3-setuptools python3-wheel \
    python3-dev build-essential pkgconf mariadb-client libmariadb-dev libkrb5-dev libsasl2-dev libldap2-dev libssl-dev \
    unixodbc nginx-light && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/archery

# download archery and install requirements
RUN curl -sSL -o archery.tar.gz 'https://github.com/hhyo/Archery/archive/refs/tags/v1.11.1.tar.gz' && \
    tar -xf archery.tar.gz --strip-components=1 && \
    rm -f archery.tar.gz && \
    # pin numpy version to 1.26.4
    echo 'numpy==1.26.4' >> requirements.txt && \
    python3 -m venv venv && \
    bash -c 'source ./venv/bin/activate && pip install --upgrade pip && pip install wheel setuptools && pip install -r requirements.txt'

ADD minit.d /etc/minit.d
ADD nginx   /etc/nginx