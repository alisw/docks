FROM centos:centos7

RUN yum update -y && yum install -y java-1.7.0-openjdk bzip2
RUN yum update -y && yum install -y git
ADD https://aphyr.com/riemann/riemann-0.2.10.tar.bz2 /riemann.tbz2
ADD https://raw.github.com/technomancy/leiningen/stable/bin/lein /usr/bin/lein
RUN git clone https://github.com/avishai-ish-shalom/riemann-elasticsearch-plugin && \
    chmod +x /usr/bin/lein
RUN cd riemann-elasticsearch-plugin                           && \
    LEIN_ROOT=1 lein uberjar                                  && \
    cd /                                                      && \
    tar xjvf /riemann.tbz2
ADD run.sh /run.sh

CMD /run.sh
