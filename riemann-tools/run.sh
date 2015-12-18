#!/bin/bash -ex
if [ ! -d /riemann-tools ]; then
  git clone https://github.com/${REPO:-aphyr/riemann-tools}
fi
echo "$@"

PATH=/riemann-tools/bin:$PATH "$@"
