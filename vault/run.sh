cat <<EOF >/vault.config
backend "zookeeper" {
  address = "127.0.0.1:2181"
  path = "vault"
  advertise_addr = "${ZOOKEEPER_ADDRESS:-zk://127.0.0.1:2181}"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}
EOF

[[ ! $DEBUG ]] && HAS_CONFIG=true

/vault server ${HAS_CONFIG:+-config /vault.config} ${DEBUG:+-dev}
