FROM centos:centos7

RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN \
  rpmdb --rebuilddb                                                                           &&  \
  yum clean all                                                                               &&  \
  yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm  &&  \
  yum install -y golang git

ENV GOPATH /usr/local/go

ENV REPO mesosphere
ENV TAG v0.5.1

RUN go get github.com/miekg/dns        && \
    go get github.com/$REPO/mesos-dns  
RUN cd $GOPATH/src/github.com/$REPO/mesos-dns && git reset --hard $TAG && git show && go build -o mesos-dns
ADD run.sh /

CMD /run.sh
