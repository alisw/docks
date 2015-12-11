#!/bin/bash -ex
# If the riemann folder does not exist, clone it from ali-bot
if [ ! -d /config ]; then
  git clone ${ALI_BOT_BRANCH:+-b $ALI_BOT_BRANCH} https://github.com/${ALI_BOT_REPO:-alisw/ali-bot} /config
fi

RIEMANN_DASH_CONFIG=/config/riemann/config.rb riemann-dash
