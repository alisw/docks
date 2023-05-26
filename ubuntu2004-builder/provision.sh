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
apt install -y build-essential curl libcurl4-gnutls-dev gfortran swig autoconf     \
    automake autopoint unzip texinfo gettext libtool libtool-bin pkg-config        \
    libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libxml2-dev flex     \
    bison libperl-dev libbz2-dev liblzma-dev libnanomsg-dev lsb-release rsync      \
    linux-headers-5.4.0-53-generic libkmod-dev libpci-dev libmotif-dev ed          \
    git environment-modules libglfw3-dev libtbb-dev libncurses-dev rclone patchelf \
    ruby-full rubygems-integration python3-dev python3-venv python3-pip            \
    python-is-python3 python2.7 libpython2.7 libsasl2-dev openjdk-8-jdk  # mesos and jenkins
# Install pip -> pip3, to match python -> python3 from python-is-python3.
update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 100

# Don't generate rdoc or ri documentation.
gem install --no-document fpm

curl -Lo /tmp/vault.zip https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip
unzip /tmp/vault.zip vault -d /usr/bin/
rm -v /tmp/vault.zip
