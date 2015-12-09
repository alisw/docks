FROM centos:centos7

RUN yum update -y && yum install -y java-1.7.0-openjdk bzip2
RUN yum update -y && yum install -y git
ADD https://aphyr.com/riemann/riemann-0.2.10.tar.bz2 /riemann.tbz2
RUN tar xjvf /riemann.tbz2
ADD run.sh /run.sh

CMD /run.sh
