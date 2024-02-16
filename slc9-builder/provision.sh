#!/bin/sh -ex

useradd -rmUu 980 mesosalien
useradd -rmUu 981 mesosci
useradd -rmUu 982 mesosdaq
useradd -rmUu 983 mesosuser
useradd -rmUu 984 mesostest

wipednf () {
  rpmdb --rebuilddb
  dnf clean all
  rm -rf /var/cache/yum
}

wipednf

dnf install -y epel-release dnf-plugins-core

# Formerly "powertools"; contains some dev tools we need.
# See also: https://wiki.almalinux.org/repos/AlmaLinux.html
dnf config-manager --set-enabled crb

dnf update -y
dnf groups install -y 'Development Tools'
# python3-{pip,setuptools} and s3cmd needed for Jenkins builds.
dnf install -y alice-o2-full-deps python3-pip python3-setuptools s3cmd

wipednf
