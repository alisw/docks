#!/bin/bash -ex
# If the riemann folder does not exist, clone it from ali-bot
if [ ! -d /config ]; then
  git clone ${ALI_BOT_BRANCH:+-b $ALI_BOT_BRANCH} https://github.com/${ALI_BOT_REPO:-alisw/ali-bot} /config
fi

if [ ! -d /riemann-dash ]; then
  git clone https://github.com/${REPO:-aphyr/riemann-dash} /riemann-dash
fi

cd /riemann-dash
git show
bundle install
RIEMANN_DASH_CONFIG=/config/riemann/config.rb bundle exec riemann-dash
