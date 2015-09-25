FROM centos:centos7

RUN rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
RUN yum update -y && yum install -y mesos-0.24.0
