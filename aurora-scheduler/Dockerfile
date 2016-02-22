FROM alisw/aurora-base:0.11.0

ADD http://people.apache.org/~wfarner/aurora/distributions/0.11.0/deb/ubuntu-trusty/aurora-scheduler_0.11.0_amd64.deb aurora-scheduler_0.11.0_amd64.deb
RUN dpkg -i aurora-scheduler_0.11.0_amd64.deb
ADD run.sh /run.sh

CMD bash -ex /run.sh
