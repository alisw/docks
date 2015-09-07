FROM alisw/mesos-base:0.23.0-cc7

RUN yum update -y  && yum -y install marathon-0.10.1
EXPOSE 8080
ADD run.sh /run.sh
RUN yum update -y && yum install -y nc

CMD /bin/sh -e -x /run.sh
