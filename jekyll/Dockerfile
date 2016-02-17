FROM centos:centos7

RUN yum update -y && yum install -y ruby ruby-devel rubygems
RUN yum update -y && yum install -y make gcc
RUN gem install jekyll
RUN yum update -y && yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum install -y nodejs git java-1.8.0-openjdk python-pip vim unzip jq

ADD https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip vault.zip
RUN unzip vault.zip && mv ./vault /usr/bin/vault

RUN pip install elasticsearch elasticsearch-dsl PyYAML
