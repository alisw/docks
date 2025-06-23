#!/bin/sh -ex

dnf update -y

groupadd -g 981 mesosci
useradd -u 981 -g 981 mesosci

dnf groups install -y 'Development Tools'

yum install -y dnf-plugins-core # Needed for config-manager
yum install -y python3-pip
yum install -y rsync # Needed for aliBuild

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io
