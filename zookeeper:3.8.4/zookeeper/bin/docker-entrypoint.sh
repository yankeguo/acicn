#!/bin/bash

ZKJVM_OPTS="${ZKJVM_OPTS}"

if [ -n "${ZKJVM_XMS}" ]; then
    ZKJVM_OPTS="${ZKJVM_OPTS} -Xms${ZKJVM_XMS}"
fi

if [ -n "${ZKJVM_XMX}" ]; then
    ZKJVM_OPTS="${ZKJVM_OPTS} -Xmx${ZKJVM_XMX}"
fi

export SERVER_JVMFLAGS="${ZKJVM_OPTS} ${SERVER_JVMFLAGS}"

exec zkServer.sh "$@"
