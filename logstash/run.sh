#!/bin/sh -ex

REPO=${LOGSTASH_REPO-alisw}

if [ ! -d /ali-bot ]; then
  git clone https://github.com/$REPO/ali-bot
fi

cp /ali-bot/logstash/logstash.conf /logstash.conf
perl -p -i -e "s/MONALISA_HOST/$MONALISA_HOST/" /logstash.conf
perl -p -i -e "s/MONALISA_PORT/$MONALISA_PORT/" /logstash.conf

if [ ! "X$DEBUG" = X ]; then
  echo 'output {stdout { codec => rubydebug }}' >> /logstash.conf
fi

/opt/logstash/bin/logstash -f /logstash.conf
