FROM centos:centos7

RUN yum update -y && yum install -y java-1.7.0-openjdk bzip2
ADD https://aphyr.com/riemann/riemann-0.2.10.tar.bz2 /riemann.tbz2
RUN tar xjvf /riemann.tbz2
ADD riemann.config /riemann.config

CMD /riemann-0.2.10/bin/riemann /riemann.config
