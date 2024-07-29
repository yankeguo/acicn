#!/bin/bash

set -eu

TAG_NAME="${1//:/--}--$(date '+%Y%m%d%H%M')"

git tag -m "$TAG_NAME" "$TAG_NAME"
