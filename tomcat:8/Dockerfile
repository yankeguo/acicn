FROM ghcr.io/yankeguo/acicn/jdk:8-240826-1208

WORKDIR /usr/local/tomcat

RUN apt-get update && \
    apt-get install -y libtcnative-1 && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sSL -o tomcat.tar.gz 'https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.100/bin/apache-tomcat-8.5.100.tar.gz' && \
    tar -xf tomcat.tar.gz --strip-components=1 && \
    rm -rf tomcat.tar.gz webapps/* && \
    curl -sSL -o webapps/ROOT.war 'https://github.com/yankeguo/EmptyWar/releases/download/v2.0.0/EmptyWar-2.0.0.war' && \
    chmod -R o=g .

ADD bin bin
ADD conf.template conf.template

ENV PATH="/usr/local/tomcat/bin:${PATH}"

ENV TOMCAT_VERSION="8"

ENV TOMCATCFG_SERVER_CONNECTOR_port="8080"
ENV TOMCATCFG_SERVER_CONNECTOR_protocol="HTTP/1.1"
ENV TOMCATCFG_SERVER_CONNECTOR_connectionTimeout="20000"
ENV TOMCATCFG_SERVER_CONNECTOR_redirectPort="8443"

ADD minit.d /etc/minit.d

ADD stress.sh /stress.sh