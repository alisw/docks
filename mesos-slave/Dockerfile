FROM alisw/mesos-base:0.24.0

RUN yum update -y && yum install -y iptables ca-certificates lxc e2fsprogs docker-io

EXPOSE 5051

ADD run.sh /run.sh

CMD /bin/sh -e -x /run.sh
