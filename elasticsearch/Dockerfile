FROM centos:centos7

RUN rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
ADD elastic.repo /etc/yum.repos.d/elastic.repo
RUN yum update -y && yum install -y elasticsearch java-1.8.0-openjdk
EXPOSE 9200
ADD run.sh /

CMD sh -ex /run.sh
