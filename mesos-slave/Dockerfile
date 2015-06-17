FROM alisw/mesos-base

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y && yum install -y iptables ca-certificates lxc e2fsprogs docker-io

EXPOSE 5051

ADD run.sh /run.sh

CMD /bin/sh -e -x /run.sh
