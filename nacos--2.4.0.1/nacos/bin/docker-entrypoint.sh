#!/bin/bash

# The official image sucks, so I write my own entrypoint script.

# We are pinned to Java 11 and has JAVA_HOME set, so we don't need to check for Java version.

set -eu

export JAVA_HOME
export JAVA="$JAVA_HOME/bin/java"
export BASE_DIR=$(
    cd $(dirname $0)/..
    pwd
)
export CUSTOM_SEARCH_LOCATIONS="file:${BASE_DIR}/conf/"

JAVA_OPTS="${JAVA_OPTS:-}"

if [[ "${NACOS_MODE}" == "standalone" ]]; then
    JAVA_OPTS="${JAVA_OPTS} ${NACOS_MEMORY_OPTS:- -Xms512m -Xmx512m -Xmn256m}"
    JAVA_OPTS="${JAVA_OPTS} -Dnacos.standalone=true"
else
    if [[ "${NACOS_EMBEDDED_STORAGE:-false}" == "true" ]]; then
        JAVA_OPTS="${JAVA_OPTS} -DembeddedStorage=true"
    fi
    JAVA_OPTS="${JAVA_OPTS} -server ${NACOS_MEMORY_OPTS:- -Xms2g -Xmx2g -Xmn1g -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=320m}"
    JAVA_OPTS="${JAVA_OPTS} -XX:-OmitStackTraceInFastThrow -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${BASE_DIR}/logs/java_heapdump.hprof"
    JAVA_OPTS="${JAVA_OPTS} -XX:-UseLargePages"
fi

if [[ "${NACOS_FUNCTION_MODE:-}" == "config" ]]; then
    JAVA_OPTS="${JAVA_OPTS} -Dnacos.functionMode=config"
elif [[ "${NACOS_FUNCTION_MODE:-}" == "naming" ]]; then
    JAVA_OPTS="${JAVA_OPTS} -Dnacos.functionMode=naming"
fi

JAVA_OPTS="${JAVA_OPTS} -Dnacos.member.list=${NACOS_MEMBER_LIST:-}"

JAVA_OPTS="${JAVA_OPTS} -Xlog:gc*:file=${BASE_DIR}/logs/nacos_gc.log:time,tags:filecount=10,filesize=100m"

JAVA_OPTS="${JAVA_OPTS} -Dloader.path=${BASE_DIR}/plugins,${BASE_DIR}/plugins/health,${BASE_DIR}/plugins/cmdb,${BASE_DIR}/plugins/selector"
JAVA_OPTS="${JAVA_OPTS} -Dnacos.home=${BASE_DIR}"
JAVA_OPTS="${JAVA_OPTS} -jar ${BASE_DIR}/target/nacos-server.jar"
JAVA_OPTS="${JAVA_OPTS} ${JAVA_OPTS_EXT:-}"
JAVA_OPTS="${JAVA_OPTS} --spring.config.additional-location=${CUSTOM_SEARCH_LOCATIONS}"
JAVA_OPTS="${JAVA_OPTS} --logging.config=${BASE_DIR}/conf/nacos-logback.xml"
JAVA_OPTS="${JAVA_OPTS} --server.max-http-header-size=524288"

mkdir -p "${BASE_DIR}/logs"

echo "Starting Nacos with JVM options: ${JAVA_OPTS}"

exec "$JAVA" $JAVA_OPTS nacos.nacos
