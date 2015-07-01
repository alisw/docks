#!/bin/sh
export ES_HEAP_SIZE=2g

cat << EOF > /usr/share/elasticsearch/config
cluster:
  name: alielastic
node:
  name: ${HOSTNAME}
EOF

/usr/share/elasticsearch/bin/elasticsearch
