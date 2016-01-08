#!/bin/sh -ex

REPO=${LOGSTASH_REPO-alisw/ali-bot}
CONFIG_DIR=${LOGSTASH_CONFIG_DIR-logstash}

if [ ! -d /config-ro ]; then
  git clone https://github.com/$REPO config-ro
fi

# Specifing the varius *_HOST variables will enable their related configuration.
mkdir -p /config
[ ! X$ELASTICSEARCH_HOST = X ] && cp /config-ro/${CONFIG_DIR}/*-elasticsearch*.conf /config
[ ! X$MESOS_HOST = X ] && cp /config-ro/${CONFIG_DIR}/*-mesos*.conf /config
[ ! X$MARATHON_HOST = X ] && cp /config-ro/${CONFIG_DIR}/*-marathon*.conf /config
[ ! X$MONALISA_HOST = X ] && cp /config-ro/${CONFIG_DIR}/*-monalisa*.conf /config
[ ! X$RIEMANN_HOST = X ] && cp /config-ro/${CONFIG_DIR}/*-riemann*.conf /config
[ ! X$REDIS_HOST = X ] && cp /config-ro/${CONFIG_DIR}/*-redis*.conf /config
cp /config-ro/${CONFIG_DIR}/*-all*.conf /config

# Substitute variables in configuration files.
perl -p -i -e "s/ELASTICSEARCH_HOST/$ELASTICSEARCH_HOST/g" /config/*.conf
perl -p -i -e "s/MARATHON_HOST/$MARATHON_HOST/g" /config/*.conf
perl -p -i -e "s/MESOS_HOST/$MESOS_HOST/g" /config/*.conf
perl -p -i -e "s/MONALISA_HOST/$MONALISA_HOST/g" /config/*.conf
perl -p -i -e "s/MONALISA_PORT/$MONALISA_PORT/g" /config/*.conf
perl -p -i -e "s/RIEMANN_HOST/$RIEMANN_HOST/g" /config/*.conf
perl -p -i -e "s/REDIS_HOST/$REDIS_HOST/g" /config/*.conf

if [ ! "X$DEBUG" = X ]; then
  cat << EOF > /config/99-output-debug.conf
output {stdout { codec => rubydebug }}
EOF
fi

/opt/logstash/bin/logstash -f /config
