FROM alisw/mesos-base:0.26.0

RUN yum -y install marathon-0.15.2 nc
EXPOSE 8080
ADD run.sh /run.sh

CMD /bin/sh -e -x /run.sh
