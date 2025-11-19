#!/bin/sh -ex

microdnf install -y epel-release  # for s3cmd
microdnf update -y
microdnf install -y shadow-utils git which s3cmd rpm-build make gcc createrepo rubygems ruby-devel \
         python3 python3-pip

python3 -m pip install --upgrade git+https://github.com/alisw/ali-bot.git

gem install --no-document fpm

useradd -rmUu 981 alipublish
microdnf remove -y shadow-utils

rpmdb --rebuilddb
microdnf clean all
rm -rf /var/cache/yum /root/.cache/pip
