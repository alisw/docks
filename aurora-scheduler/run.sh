AURORA_MESOS_MASTER=${AURORA_MESOS_MASTERS:-zk://127.0.0.1:2181/mesos}

mkdir -p /var/lib/aurora/scheduler/db /var/lib/aurora-backup
mesos-log initialize --path=/var/lib/aurora/scheduler/db && true

/usr/lib/aurora/bin/aurora-scheduler -mesos_master_address=${AURORA_MESOS_MASTERS} \
  -cluster_name=${AURORA_CLUSTER_NAME:-mesos}                  \
  -serverset_path=/aurora/scheduler                            \
  -native_log_quorum_size=${QUORUM_SIZE:-1}                    \
  -backup_dir=/var/lib/aurora-backup                           \
  -http_port=8081                                              \
  -native_log_file_path=/var/lib/aurora/scheduler/db           \
  -thermos_executor_path=${THERMOS_EXECUTOR_PATH:-/dev/null}   \
  -zk_endpoints=${ZK_ENDPOINTS:-127.0.0.1:2181}                \
  -native_log_zk_group_path=/aurora/replicated-log
