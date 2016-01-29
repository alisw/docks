FROM alisw/mesos-base:0.24.0

RUN yum -y install marathon-0.14.0
EXPOSE 8080
ADD run.sh /run.sh
RUN yum update -y && yum install -y nc

CMD /bin/sh -e -x /run.sh
