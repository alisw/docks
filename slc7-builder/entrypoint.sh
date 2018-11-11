#!/bin/bash
export PATH=/root/.rbenv/bin:$PATH
eval "$(rbenv init -)"
exec "$@"
