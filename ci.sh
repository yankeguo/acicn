#!/bin/bash

set -eu

case "$1" in
"decode-ref")
    IFS='|' read -ra ADDR <<<"${2//--/|}"

    if [ ${#ADDR[@]} -lt 3 ]; then
        echo "Invalid ref: $1"
        exit 1
    fi

    echo "context=${ADDR[0]}--${ADDR[1]}"
    echo "name=${ADDR[0]}"
    echo "tag=${ADDR[1]}-${ADDR[2]}"
    ;;
"create-tag")
    TAG_NAME="$(basename $(pwd))--$(date '+%y%m%d-%H%M')"
    git tag -m "$TAG_NAME" "$TAG_NAME"
    git push --tags origin main:main
    ;;
"delete-tag")
    git tag -d "$2"
    git push origin --delete "$2"
    ;;
"build")
    docker build -t "acicn-$(basename $(pwd))" .
    ;;
"run")
    shift
    docker run --rm $@ "acicn-$(basename $(pwd))"
    ;;
*)
    echo "Unknown command: $1"
    exit 1
    ;;
esac
