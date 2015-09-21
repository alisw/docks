FROM centos:centos7

ADD logstash.repo /etc/yum.repos.d/logstash.repo
RUN yum update -y && yum install -y logstash which java-1.8.0-openjdk-headless git

ADD mesos-patterns.conf /opt/logstash/patterns/mesos
ADD run.sh /
RUN /opt/logstash/bin/plugin install logstash-input-http_poller

CMD /usr/bin/java -version && sh -e -x /run.sh
