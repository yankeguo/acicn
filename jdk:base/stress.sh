#!/bin/bash

set -eux

JAVA_OPTS_METRICS=-javaagent:/opt/lib/jmx_prometheus_javaagent.jar=60030:/opt/etc/jmx_prometheus_javaagent/simple.yml \
    JAVA_OPTS_TRACING=-javaagent:/opt/lib/skywalking-agent/skywalking-agent.jar \
    JAVA_XMS=256m JAVA_XMX=256m java-wrapper -jar /opt/EmptyJar.jar &

SERVICE_PID="$!"

trap "kill -TERM ${SERVICE_PID}" EXIT

sleep 20

ab -n 10000 -c 400 http://127.0.0.1:8080/
