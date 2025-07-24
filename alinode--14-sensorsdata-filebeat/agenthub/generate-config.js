'use strict';

const fs = require('fs');

const defaults = {
    "server": "wss://agentserver.node.aliyun.com:8080",
    "heartbeatInterval": 60,
    "reconnectDelay": 10,
    "reportInterval": 60,
    "error_log": []
};

var custom = {};

if (fs.existsSync(`/root/app-config.json`)) {
    custom = require(`/root/app-config.json`);
}

const config = Object.assign(defaults, custom);

config.appid = config.appid || process.env.APP_ID;
config.secret = config.secret || process.env.APP_SECRET;
config.logdir = config.logdir || process.env.NODE_LOG_DIR || '/var/log/agenthub';

if (config.appid && config.secret) {
    fs.writeFileSync("config.json", JSON.stringify(config, null, 2));
}
