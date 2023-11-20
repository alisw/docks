#!/bin/sh -ex

microdnf install -y epel-release  # for s3cmd
microdnf update -y
microdnf install -y shadow-utils git curl s3cmd rpm-build createrepo \
         python3 python3-pip python3-setuptools rubygems
alternatives --set python /usr/bin/python3

gem install --no-document fpm

useradd -rmUu 981 alipublish
microdnf remove shadow-utils

rpmdb --rebuilddb
microdnf clean all
rm -rf /var/cache/yum /root/.cache/pip
