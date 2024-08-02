FROM ghcr.io/yankeguo/acicn/debian:12-240731-1022

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

ENV LD_LIBRARY_PATH="/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/lib/x86_64-linux-gnu"
ENV JAVA_HOME="/usr/lib/jvm/temurin-${JDK_VERSION}-jdk-amd64"

RUN "${JAVA_HOME}/bin/java" -version && echo "JAVA_HOME: OK"

WORKDIR /opt/seata

ENV SEATA_VERSION 1.7.1

RUN curl -sSL -o seata.tar.gz "https://github.com/apache/incubator-seata/releases/download/v${SEATA_VERSION}/seata-server-${SEATA_VERSION}.tar.gz" && \
    tar -xvf seata.tar.gz --strip-components=1 && \
    rm -f seata.tar.gz && \
    rm -rf conf/application*

ADD seata ./

ADD minit.d /etc/minit.d

####################################
# Startup Parameters
####################################

# ENV SEATA_CLASSPATH_EXTRA=""

# ENV SEATA_MEMORY_OPTS="-Xms512m -Xmx512m -Xmn256m"

# ENV SEATA_ARGS=""

####################################
# Application Properties
####################################

ENV SEATA_CONF_server.port="7091"
ENV SEATA_CONF_spring.application.name="seata-server"
ENV SEATA_CONF_logging.config="classpath:logback-spring.xml"
ENV SEATA_CONF_logging.file.path="\${log.home}"
ENV SEATA_CONF_logging.extend.logstash-appender.destination="127.0.0.1:4560"
ENV SEATA_CONF_logging.extend.kafka-appender.bootstrap-servers="127.0.0.1:9092"
ENV SEATA_CONF_logging.extend.kafka-appender.topic="logback_to_logstash"
ENV SEATA_CONF_console.user.username="seata"
ENV SEATA_CONF_console.user.password="seata"
ENV SEATA_CONF_seata.config.type="file"
ENV SEATA_CONF_seata.registry.type="file"
ENV SEATA_CONF_seata.store.mode="file"
ENV SEATA_CONF_seata.security.secretKey="SeataSecretKey0c382ef121d778043159209298fd40bf3850a017"
ENV SEATA_CONF_seata.security.tokenValidityInMilliseconds="1800000"
ENV SEATA_CONF_seata.security.ignore.urls="/,/**/*.css,/**/*.js,/**/*.html,/**/*.map,/**/*.svg,/**/*.png,/**/*.jpeg,/**/*.ico,/api/v1/auth/login"