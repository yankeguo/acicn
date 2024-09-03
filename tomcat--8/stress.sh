#!/bin/bash

set -eux

sleep 10

ab -n 10000 -c 400 http://127.0.0.1:8080/
