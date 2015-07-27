FROM alisw/slc6-vanilla


RUN rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm
RUN yum update -y && yum install -y mesos
