FROM centos:centos7

RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
ADD docker.repo /etc/yum.repos.d/docker.repo
RUN yum update -y && yum install -y mesos-0.25.0 docker-engine-1.10.1
