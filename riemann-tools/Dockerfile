FROM alisw/slc7-builder

RUN yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum update -y && yum install -y rubygems ruby-devel
RUN gem install riemann-tools 
