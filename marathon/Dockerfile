FROM alisw/mesos-base:0.27.2

RUN yum -y install marathon-0.15.3 nc && yum clean all -y
EXPOSE 8080
ADD run.sh /run.sh

CMD /bin/sh -e -x /run.sh
