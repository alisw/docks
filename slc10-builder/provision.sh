#!/bin/sh -ex

useradd -rmUu 980 mesosalien
useradd -rmUu 981 mesosci
useradd -rmUu 982 mesosdaq
useradd -rmUu 983 mesosuser
useradd -rmUu 984 mesostest

# No "rpmdb --rebuilddb" here: it only compacted the old Berkeley DB backend, and
# on EL10 (rpmdb at /usr/lib/sysimage/rpm, sqlite backend) it fails outright with
# "failed to replace old database with new database!".
wipednf () {
  dnf clean all
  rm -rf /var/cache/yum /var/cache/dnf
}

wipednf

dnf install -y epel-release dnf-plugins-core

# Formerly "powertools"; contains some dev tools we need.
# See also: https://wiki.almalinux.org/repos/AlmaLinux.html
dnf config-manager --set-enabled crb

dnf update -y
dnf groups install -y 'Development Tools'
# python3-{pip,setuptools} and s3cmd needed for Jenkins builds.
# pigz: aliBuild uses it in place of gzip for package tarballs when present.
# freeglut ... libxkbcommon are used for the O2 GPU Standalone build with event display
dnf install -y alice-o2-full-deps python3-pip python3-setuptools s3cmd time pigz \
  freeglut-devel libdrm-devel vulkan-loader-devel glslc wayland-devel wayland-protocols-devel libxkbcommon-devel

# Jenkins' slave.jar needs a JRE. On EL9 one arrived as a dependency; EL10 ships
# only OpenJDK 21 and 25, so nothing pulls one and the agent died with
# "java: command not found". 21 is what this Jenkins supports; 25 is untested.
dnf install -y java-21-openjdk-headless

curl https://s3.cern.ch/swift/v1/alibuild-repo/bin/recc -L -o /usr/bin/recc
chmod +x /usr/bin/recc

wipednf
