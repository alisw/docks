#!/usr/bin/bash
set -exo pipefail

# Create users and groups for mesos. -r -U means that the groups created
# automatically for each user will have the same gid as the uid (so group
# mesosalien will have gid 980, and so on).
useradd -rUu 980 mesosalien
useradd -rUu 981 mesosci
useradd -rUu 982 mesosdaq
useradd -rUu 983 mesosuser
useradd -rUu 984 mesostest

export DEBIAN_FRONTEND=noninteractive
apt update -y
apt upgrade -y
apt install -y apt-utils
apt install -y build-essential autoconf automake autopoint bison flex \
    gettext gfortran gtk-doc-tools libtool libtool-bin pkg-config \
    texinfo libbz2-dev libcurl4-gnutls-dev libfftw3-dev libglfw3-dev \
    libglu1-mesa-dev libkmod-dev liblzma-dev libmotif-dev \
    libmysqlclient-dev libnanomsg-dev libncurses-dev libpci-dev \
    libperl-dev libtbb-dev libxml2-dev linux-headers-generic \
    lsb-release swig xorg-dev unzip curl rsync ed git pigz rclone \
    environment-modules ruby-full rubygems-integration python3-dev \
    python3-venv python3-pip python-is-python3 \
    openjdk-8-jdk  # for Jenkins

# Don't generate rdoc or ri documentation.
gem install --no-document fpm
