if [[ ! $TLS_CERT_FILE ]]; then
  export TLS_DISABLE=1
fi
export Q=\"

cat <<EOF >/vault.config
backend "zookeeper" {
  address = "127.0.0.1:2181"
  path = "vault"
  advertise_addr = "${ZOOKEEPER_ADDRESS:-zk://127.0.0.1:2181}"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  ${TLS_DISABLE:+tls_disable = 1}
  ${TLS_CERT_FILE:+tls_cert_file = $Q${TLS_CERT_FILE}$Q}
  ${TLS_KEY_FILE:+tls_key_file = $Q${TLS_KEY_FILE}$Q}
}
EOF

[[ ! $DEBUG ]] && HAS_CONFIG=true

/vault server ${HAS_CONFIG:+-config /vault.config} ${DEBUG:+-dev}
