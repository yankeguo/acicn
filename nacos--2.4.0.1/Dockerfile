FROM ghcr.io/yankeguo/acicn/debian:12-240731-1022

ENV JAVA_VERSION=11
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

WORKDIR /opt/nacos

ENV NACOS_VERSION="2.4.0.1"

RUN curl -sSL -o nacos.tar.gz "https://github.com/alibaba/nacos/releases/download/${NACOS_VERSION}/nacos-server-${NACOS_VERSION}.tar.gz" && \
    tar -xvf nacos.tar.gz --strip-components=1 && \
    rm -f nacos.tar.gz

ADD nacos /opt/nacos
ADD minit.d /etc/minit.d

####################################
# Cluster
####################################

# must set NACOS_MODE to "standalone" or "cluster"
ENV NACOS_MODE="cluster"

# conf/cluster.conf file
# ENV NACOS_CLUSTER_CONF=""
# ENV MINIT_ENV_NACOS_CLUSTER_CONF='{{netResolveIP "nacos-1"}}:8848;{{netResolveIP "nacos-2"}}:8848;{{netResolveIP "nacos-3"}}:8848'

####################################
# Startup Parameters
####################################

# ENV NACOS_MEMORY_OPTS="-Xms512m -Xmx512m -Xmn256m"

# ENV NACOS_FUNCTION_MODE=""
# ENV NACOS_MEMBER_LIST=""
# ENV NACOS_EMBEDDED_STORAGE="false"

####################################
# Application Properties
####################################

ENV NACOS_CONF_server.error.include-message="ALWAYS"
ENV NACOS_CONF_server.servlet.contextPath="/nacos"
ENV NACOS_CONF_server.port="8848"
ENV NACOS_CONF_db.pool.config.connectionTimeout="30000"
ENV NACOS_CONF_db.pool.config.validationTimeout="10000"
ENV NACOS_CONF_db.pool.config.maximumPoolSize="20"
ENV NACOS_CONF_db.pool.config.minimumIdle="2"
ENV NACOS_CONF_nacos.config.push.maxRetryTime="50"
ENV NACOS_CONF_server.tomcat.mbeanregistry.enabled="true"
ENV NACOS_CONF_management.metrics.export.elastic.enabled="false"
ENV NACOS_CONF_management.metrics.export.influx.enabled="false"
ENV NACOS_CONF_server.tomcat.accesslog.enabled="true"
ENV NACOS_CONF_server.tomcat.accesslog.rotate="true"
ENV NACOS_CONF_server.tomcat.accesslog.file-date-format=".yyyy-MM-dd-HH"
ENV NACOS_CONF_server.tomcat.accesslog.pattern='%h %l %u %t "%r" %s %b %D %{User-Agent}i %{Request-Source}i'
ENV NACOS_CONF_server.tomcat.basedir=file:.
ENV NACOS_CONF_nacos.security.ignore.urls="/,/error,/**/*.css,/**/*.js,/**/*.html,/**/*.map,/**/*.svg,/**/*.png,/**/*.ico,/console-ui/public/**,/v1/auth/**,/v1/console/health/**,/actuator/**,/v1/console/server/**"
ENV NACOS_CONF_nacos.core.auth.system.type="nacos"
ENV NACOS_CONF_nacos.core.auth.enabled="false"
ENV NACOS_CONF_nacos.core.auth.caching.enabled="true"
ENV NACOS_CONF_nacos.core.auth.enable.userAgentAuthWhite="false"
ENV NACOS_CONF_nacos.core.auth.server.identity.key=""
ENV NACOS_CONF_nacos.core.auth.server.identity.value=""
ENV NACOS_CONF_nacos.core.auth.plugin.nacos.token.cache.enable="false"
ENV NACOS_CONF_nacos.core.auth.plugin.nacos.token.expire.seconds="18000"
ENV NACOS_CONF_nacos.core.auth.plugin.nacos.token.secret.key=""
ENV NACOS_CONF_nacos.istio.mcp.server.enabled="false"
ENV NACOS_CONF_nacos.console.ui.enabled="true"