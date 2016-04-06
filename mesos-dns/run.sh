#!/bin/sh -e

# Creates the config and runs mesos-dns.

for x in `echo ${MESOS_DNS_MASTERS-127.0.0.1:5050} | tr , \\ `; do
  MASTERS="$MASTERS, \"$x\""
done
MASTERS=`echo $MASTERS | sed -e 's/^, //'`

for x in `echo ${MESOS_DNS_RESOLVERS-8.8.8.8} | tr , \\ `; do
  RESOLVERS="$RESOLVERS, \"$x\""
done
RESOLVERS=`echo $RESOLVERS | sed -e 's/^, //'`

ZK="\"zk\": \"$MESOS_DNS_ZK\","

cat << EOF > /config.json
{
  ${MESOS_DNS_ZK+$ZK}
  "refreshSeconds": ${MESOS_DNS_REFRESH-60},
  "ttl": ${MESOS_DNS_TTL-60},
  "domain": "${MESOS_DNS_DOMAIN-mesos}",
  "port": ${MESOS_DNS_PORT-53},
  "resolvers": [${RESOLVERS}],
  "email": "${MESOS_DNS_EMAIL-root.mesos-dns.mesos}",
  "timeout": ${MESOS_DNS_TIMEOUT-5}
}
EOF

export GOPATH=/usr/local/go
/usr/local/go/bin/mesos-dns ${VERBOSE+-v} -config /config.json
