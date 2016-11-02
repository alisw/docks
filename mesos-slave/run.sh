#!/bin/sh -e -x

# Simply starts the mesos slave.
#
# Notice that in case of a frontend, we expose port 53 as well
# as a valid resource.
groupadd -g ${JENKINS_GID:-2000} jenkins || true
useradd -u ${JENKINS_UID:-501} -g ${JENKINS_GID:-2000} jenkins || true

# Creates a modules configuration file which can be used to overestimate
# the available CPU resources and to remove the oversubscribed tasks
# when the load becomes too high.
cat <<EOF > /etc/mesos-slave/modules
{
  "libraries":
  [
    {
      "file": "/usr/lib/libfixed_resource_estimator.so",
      "modules": {
        "name": "org_apache_mesos_FixedResourceEstimator",
        "parameters": {
          "key": "resources",
          "value": "cpus:$((`nproc` + ${MESOS_EXTRA_CPUS:-0}))"
        }
      }
    },
    {
      "file": "/usr/lib/libload_qos_controller.so",
      "modules": {
        "name": "org_apache_mesos_LoadQoSController",
        "parameters": [
          {
            "key": "load_threshold_5min",
            "value": "$((`nproc` + ${MESOS_EXTRA_CPUS:-0} + 3))"
          },
          {
            "key": "load_threshold_15min",
            "value": "$((`nproc` + ${MESOS_EXTRA_CPUS:-0} + 2))"
          }
        ]
      }
    }
  ]
}
EOF

mesos-slave --master=${MESOS_MASTER_ZK-zk://localhost:2181/mesos}                \
             --work_dir=${MESOS_MASTER_WORKDIR-/var/lib/mesos}                   \
             ${MESOS_SLAVE_FRONTEND+--resources='ports(*):[31000-32000, 53-53]'} \
             --containerizers=docker,mesos
