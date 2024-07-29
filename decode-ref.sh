#!/bin/bash

set -eu

IFS='|' read -ra ADDR <<<"${1//--/|}"

if [ ${#ADDR[@]} -lt 3 ]; then
    echo "Invalid ref: $1"
    exit 1
fi

echo "context=${ADDR[0]}:${ADDR[1]}"
echo "name=${ADDR[0]}"
echo "tag=${ADDR[1]}-${ADDR[2]}"
