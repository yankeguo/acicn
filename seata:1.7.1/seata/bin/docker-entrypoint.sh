#!/bin/bash

# The official image sucks, so I write my own entrypoint script.

# We are pinned to Java 17 and has JAVA_HOME set, so we don't need to check for Java version.

set -eu

export JAVA_HOME
export JAVA="$JAVA_HOME/bin/java"
export BASE_DIR=$(
    cd $(dirname $0)/..
    pwd
)
export LOGS_DIR="${BASE_DIR}/logs"

mkdir -p "${LOGS_DIR}"

CLASSPATH="$BASE_DIR/conf:$BASE_DIR/lib/*"

JAVA_OPTS="${JAVA_OPTS:-}"

SEATA_CLASSPATH_EXTRA="${SEATA_CLASSPATH_EXTRA:-}"

if [[ -n "$SEATA_CLASSPATH_EXTRA" ]]; then
    CLASSPATH="$SEATA_CLASSPATH_EXTRA:$CLASSPATH"
fi

if [[ "${SEATA_SKYWALKING_ENABLED:-}" == "true" ]]; then
    JAVA_OPTS="${JAVA_OPTS} -javaagent:${BASE_DIR}/ext/apm-skywalking/skywalking-agent.jar -Dskywalking_config=${BASE_DIR}/ext/apm-skywalking/config/agent.config -Dskywalking.logging.dir=${BASE_DIR}/logs"
fi

JAVA_OPTS="${JAVA_OPTS} -Dlog.home=${LOGS_DIR} -server -Dloader.path=${BASE_DIR}/lib"
JAVA_OPTS="${JAVA_OPTS} ${SEATA_MEMORY_OPTS:- -Xms512m -Xmx512m -Xmn256m}"
JAVA_OPTS="${JAVA_OPTS} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${LOGS_DIR}/java_heapdump.hprof -XX:+DisableExplicitGC"
JAVA_OPTS="${JAVA_OPTS} -Xlog:gc=trace:file=${LOGS_DIR}/seata_gc.log:time,tags:filecount=10,filesize=10M"
JAVA_OPTS="${JAVA_OPTS} -Dio.netty.leakDetectionLevel=advanced"
JAVA_OPTS="${JAVA_OPTS} -Dapp.name=seata-server -Dapp.pid=${$} -Dapp.home=${BASE_DIR} -Dbasedir=${BASE_DIR}"
JAVA_OPTS="${JAVA_OPTS} -Dspring.config.additional-location=${BASE_DIR}/conf/ -Dspring.config.location=${BASE_DIR}/conf/application.yml -Dlogging.config=${BASE_DIR}/conf/logback-spring.xml"
JAVA_OPTS="${JAVA_OPTS} -jar ${BASE_DIR}/target/seata-server.jar"

echo "Starting Seata with JVM options: java ${JAVA_OPTS} ${SEATA_ARGS:-}"

exec java ${JAVA_OPTS} ${SEATA_ARGS:-}
