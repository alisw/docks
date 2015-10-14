#!/bin/sh -e -x

# Simply starts the mesos slave.
#
# Notice that in case of a frontend, we expose port 53 as well
# as a valid resource.
groupadd -g ${JENKINS_GID:-2000} jenkins
useradd -u ${JENKINS_UID:-501} -g ${JENKINS_GID:-2000} jenkins
mesos-slave --master=${MESOS_MASTER_ZK-zk://localhost:2181/mesos}                \
             --work_dir=${MESOS_MASTER_WORKDIR-/var/lib/mesos}                   \
             ${MESOS_SLAVE_FRONTEND+--resources='ports(*):[31000-32000, 53-53]'} \
             --containerizers=docker,mesos
