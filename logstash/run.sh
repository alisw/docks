#!/bin/sh -ex

REPO=${LOGSTASH_REPO-alisw}

git clone https://github.com/$REPO/ali-bot

if [ ! "X$DEBUG" = X ]; then
  echo 'output {stdout { codec => rubydebug }}' >> /ali-bot/logstash/logstash.conf
fi

/opt/logstash/bin/logstash -f /ali-bot/logstash/logstash.conf
