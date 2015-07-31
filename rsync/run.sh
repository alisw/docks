VOLUME=/data/store
ALLOW=${ALLOW:-192.168.0.0/16 172.16.0.0/12}
OWNER=${OWNER:-root}
GROUP=${GROUP:-root}

#chown "${OWNER}:${GROUP}" "${VOLUME}"

mkdir -p $VOLUME
cat <<EOF > /etc/rsyncd.conf
uid = ${OWNER}
gid = ${GROUP}
use chroot = yes
pid file = /var/run/rsyncd.pid
log file = /dev/stdout
[store]
    hosts deny = *
    hosts allow = ${ALLOW}
    read only = false
    path = ${VOLUME}
EOF

cat /etc/rsyncd.conf
exec /usr/bin/rsync --no-detach --daemon --config /etc/rsyncd.conf "$@"
