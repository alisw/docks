#!/bin/bash -ex
AURORA_HOME=/usr/lib/aurora
AURORA_MESOS_MASTER=${AURORA_MESOS_MASTERS:-zk://127.0.0.1:2181/mesos}

mkdir -p /var/lib/aurora/scheduler/db /var/lib/aurora-backup
mesos-log initialize --path=/var/lib/aurora/scheduler/db && true

JAVA_OPTS=(
  -Xmx2g
  -Xms2g
  -XX:+UseG1GC
  -XX:+UseStringDeduplication
  # GC tuning, etc.
)


AURORA_FLAGS=(
  -mesos_master_address=${AURORA_MESOS_MASTERS}
  -cluster_name=${AURORA_CLUSTER_NAME:-mesos}
  -serverset_path=${AURORA_SERVERSET_PATH:-/aurora/scheduler}
  -native_log_quorum_size=${QUORUM_SIZE:-1}
  -backup_dir=/var/lib/aurora-backup
  -http_port=8081
  -native_log_file_path=/var/lib/aurora/scheduler/db
  -thermos_executor_path=${THERMOS_EXECUTOR_PATH:-/usr/bin/thermos_executor}
  -zk_endpoints=${ZK_ENDPOINTS:-127.0.0.1:2181}
  -native_log_zk_group_path=${AURORA_NATIVE_LOG_ZK_GROUP_PATH:-/aurora/replicated-log}
  -thermos_executor_cpu=0
  -thermos_executor_ram=128MB
  -max_schedule_penalty=20secs
  -min_offer_hold_time=1mins
  ${AURORA_SHIRO_AFTER_AUTH_FILTER:+-shiro_after_auth_filter=${AURORA_SHIRO_AFTER_AUTH_FILTER}}
  ${AURORA_SHIRO_REALM_MODULES:+-shiro_realm_modules=${AURORA_SHIRO_REALM_MODULES}}
  ${AURORA_SHIRO_INI_PATH:+-shiro_ini_path=${AURORA_SHIRO_INI_PATH}}
  ${AURORA_HTTP_AUTHENTICATION_MECHANISM:+-http_authentication_mechanism=${AURORA_HTTP_AUTHENTICATION_MECHANISM}}
  ${AURORA_ALLOWED_CONTAINER_TYPES:+-allowed_container_types $AURORA_ALLOWED_CONTAINER_TYPES}
  ${AURORA_REVOCABLE_RESOURCES:+-receive_revocable_resources=$AURORA_REVOCABLE_RESOURCES}
  ${AURORA_TIER_CONFIG:+-tier_config=$AURORA_TIER_CONFIG}
)

JAVA_OPTS="${JAVA_OPTS[*]}" exec "$AURORA_HOME/bin/aurora-scheduler" "${AURORA_FLAGS[@]}"
