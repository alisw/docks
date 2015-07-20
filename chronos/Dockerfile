FROM alisw/mesos-base

RUN rpm -Uvh http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
RUN yum update -y && yum -y install chronos

COPY run.sh /run.sh

CMD sh -ex /run.sh
