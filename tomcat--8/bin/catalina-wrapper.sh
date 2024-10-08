#!/bin/bash

JAVA_OPTS="${JAVA_OPTS}"

if [ -n "${JAVA_MEMORY_MAX}" ]; then
    JAVA_OPTS="${JAVA_OPTS} -Xmx${JAVA_MEMORY_MAX}"
fi
if [ -n "${JAVA_MEMORY_MIN}" ]; then
    JAVA_OPTS="${JAVA_OPTS} -Xms${JAVA_MEMORY_MIN}"
fi
if [ -n "${JAVA_XMX}" ]; then
    JAVA_OPTS="${JAVA_OPTS} -Xmx${JAVA_XMX}"
fi
if [ -n "${JAVA_XMS}" ]; then
    JAVA_OPTS="${JAVA_OPTS} -Xms${JAVA_XMS}"
fi

for KEY in ${!JAVA_OPTS_@}; do
    JAVA_OPTS="${!KEY} ${JAVA_OPTS}"
done

export JAVA_OPTS

exec "$(dirname "$0")/catalina.sh" "$@"
