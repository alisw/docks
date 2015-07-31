FROM centos:centos7

# Patch redhat-release: pretend to be SLC7
RUN yum update -y && yum install -y rsync
ADD run.sh /run.sh

CMD sh -ex /run.sh
