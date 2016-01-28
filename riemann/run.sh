#!/bin/bash -ex
# If the riemann folder does not exist, clone it from ali-bot
if [ ! -d /config ]; then
  git clone ${ALI_BOT_BRANCH:+-b $ALI_BOT_BRANCH} https://github.com/${ALI_BOT_REPO:-alisw/ali-bot} /config
fi
RIEMANN_HOME=/riemann-0.2.10
RIEMANN_ELASTIC=/riemann-elasticsearch-plugin
test -f ${RIEMANN_HOME}/lib/riemann.jar
ls /riemann-elasticsearch-plugin/target/
test -f ${RIEMANN_ELASTIC}/target/riemann-elasticsearch-output-0.1.1-SNAPSHOT-standalone.jar
java -server -cp /jars/joda-time-2.8.2.jar:/jars/clj-time-0.11.0.jar:${RIEMANN_HOME}/lib/riemann.jar:${RIEMANN_ELASTIC}/target/riemann-elasticsearch-output-0.1.1-SNAPSHOT-standalone.jar clojure.main -m riemann.bin /config/riemann/riemann.config
