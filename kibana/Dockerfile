FROM centos:centos7

EXPOSE 5601
# Create initial web server.
RUN yum install -y tar
ADD https://download.elasticsearch.org/kibana/kibana/kibana-4.2.0-linux-x64.tar.gz /kibana.tgz
WORKDIR /
RUN tar xvzf /kibana.tgz && mv /kibana-* /kibana
ADD run.sh /run.sh

CMD sh -ex /run.sh
