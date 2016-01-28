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
RUN mkdir /jars
ADD https://clojars.org/repo/clj-time/clj-time/0.11.0/clj-time-0.11.0.jar /jars
ADD https://repo1.maven.org/maven2/joda-time/joda-time/2.8.2/joda-time-2.8.2.jar /jars
ADD run.sh /run.sh

CMD /run.sh
