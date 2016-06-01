FROM ubuntu:16.04

RUN \
  apt-get --yes --force-yes update &&                                                                     \
  apt-get install --yes --force-yes curl build-essential gfortran subversion wget                         \
    libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libssl-dev libxml2-dev libtool              \
    automake git unzip openjdk-8-jre bc time libbz2-dev python-dev python-yaml                            \
    libcurl4-openssl-dev flex bison screen tcl libtcl8.5 tk zip unzip zsh texinfo libncurses5-dev vim-nox \
    valgrind gdb inetutils-ping libperl-dev python-pip &&                                                 \
  apt-get --yes --force-yes clean

RUN curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip &&        \
    unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip
