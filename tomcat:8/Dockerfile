FROM tomcat:8.5.100 AS upstream

FROM ghcr.io/yankeguo/acicn/jdk:8-240826-1208

# vanilla tomcat
COPY --from=upstream /usr/local/tomcat /usr/local/tomcat

ENV TOMCAT_MAJOR=8
ENV TOMCAT_VERSION=8.5.100
ENV TOMCAT_NATIVE_LIBDIR=/usr/local/tomcat/native-jni-lib
ENV LD_LIBRARY_PATH="${TOMCAT_NATIVE_LIBDIR}:${LD_LIBRARY_PATH}"
ENV PATH="/work/tomcat/bin:/usr/local/tomcat/bin:${PATH}"

WORKDIR /usr/local/tomcat

# extra configuration
ADD bin bin
ADD conf.template conf.template
RUN curl -sSL -o webapps/ROOT.war 'https://github.com/yankeguo/EmptyWar/releases/download/v3.0.0/EmptyWar.war'

ENV TOMCATCFG_SERVER_CONNECTOR_port="8080"
ENV TOMCATCFG_SERVER_CONNECTOR_protocol="HTTP/1.1"
ENV TOMCATCFG_SERVER_CONNECTOR_connectionTimeout="20000"
ENV TOMCATCFG_SERVER_CONNECTOR_redirectPort="8443"

ADD minit.d /etc/minit.d

ADD stress.sh /stress.sh
