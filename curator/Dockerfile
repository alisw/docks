FROM centos:centos7

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
ADD curator.repo /etc/yum.repos.d/curator.repo
RUN yum update -y && yum install -y python-elasticsearch-curator python-setuptools
