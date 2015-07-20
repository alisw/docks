#!/bin/sh -ex
export MESOS_NATIVE_JAVA_LIBRARY=/usr/local/lib/libmesos.so
java -cp  /usr/bin/chronos org.apache.mesos.chronos.scheduler.Main --master zk://leader.mesos:2181/mesos  --zk_hosts leader.mesos:2181
