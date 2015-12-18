FROM alisw/slc7-builder

RUN yum update -y && yum install -y rubygems ruby-devel
RUN gem install riemann-tools
ADD run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]
CMD [ ]
