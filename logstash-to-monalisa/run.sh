#!/bin/sh -ex
REPO=${LOGSTASH_REPO-alisw}

git clone https://github.com/$REPO/ali-bot

perl -p -i -e "s/MONALISA_HOST/$MONALISA_HOST/" /ali-bot/logstash/to_monalisa.conf
perl -p -i -e "s/MONALISA_PORT/$MONALISA_PORT/" /ali-bot/logstash/to_monalisa.conf

if [ ! "X$DEBUG" = X ]; then
  echo 'output {stdout { codec => rubydebug }}' >> /ali-bot/logstash/to_monalisa.conf
fi

/opt/logstash/bin/logstash -f /ali-bot/logstash/to_monalisa.conf
