#!/bin/bash

# The official image sucks, so I write my own entrypoint script.

# We are pinned to Java 11 and has JAVA_HOME set, so we don't need to check for Java version.

set -eu

# working directory must be the 'bin'
cd "$(dirname "$0")"

export JAVA_HOME
export JAVA="$JAVA_HOME/bin/java"
export BASE_DIR=$(
    cd $(dirname $0)/..
    pwd
)

mkdir -p "${BASE_DIR}/logs"

JAVA_OPTS="${JAVA_OPTS:-}"

JAVA_OPTS="-server -XX:+UseG1GC -XX:MaxGCPauseMillis=250 -XX:+UseGCOverheadLimit -XX:+ExplicitGCInvokesConcurrent $JAVA_OPTS"

JAVA_OPTS="${JAVA_OPTS} -XX:-UseBiasedLocking -XX:-OmitStackTraceInFastThrow -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${BASE_DIR}/logs"

JAVA_OPTS="${JAVA_OPTS} ${CANAL_MEMORY_OPTS:- -Xms512m -Xmx512m}"

JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true -Djava.net.preferIPv4Stack=true -Dfile.encoding=UTF-8"

JAVA_OPTS="${JAVA_OPTS} -DappName=otter-canal -Dlogback.configurationFile=${BASE_DIR}/conf/logback.xml -Dcanal.conf=${BASE_DIR}/conf/canal.properties"

CLASSPATH=".:${BASE_DIR}/conf"

for LIB in ${BASE_DIR}/lib/*; do
    CLASSPATH="${CLASSPATH}:${LIB}"
done

JAVA_OPTS="${JAVA_OPTS} -cp ${CLASSPATH} com.alibaba.otter.canal.deployer.CanalLauncher"

echo "Starting Canal Deployer with JAVA_OPTS: ${JAVA_OPTS}"

exec java ${JAVA_OPTS}
