#!/bin/bash

set -eux

cat <<-EOF > /tmp/stress-server.js
var http = require('http');
http.createServer(function (req, res) {
  res.write('Hello World!');
  res.end();
}).listen(3000);
EOF

node /tmp/stress-server.js &

SERVICE_PID="$!"

trap "kill -TERM ${SERVICE_PID}" EXIT

sleep 10

ab -n 10000 -c 400 http://127.0.0.1:3000/
