# alisw/ubuntu1404-builder:v4

FROM ubuntu:14.04

# Patch uname
COPY mock-uname-ubuntu1404.sh /bin/uname

# No extra repos needed
RUN \
  sed -i -e 's|http://archive.ubuntu.com/ubuntu/|mirror://mirrors.ubuntu.com/mirrors.txt|g' /etc/apt/sources.list && \
  apt-get --yes --force-yes update && \
  apt-get install --yes --force-yes curl build-essential gfortran subversion wget \
    libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libssl-dev libxml2-dev libtool \
    automake git unzip libcgal-dev libmpfr4 libmpfr-dev libcgal10 libcgal-dev openjdk-7-jre \
    bc time libbz2-dev python-dev python-yaml libcurl4-openssl-dev \
    flex bison swig screen tcl tk zip unzip zsh texinfo libncurses5-dev vim-nox valgrind gdb && \
  apt-get --yes --force-yes clean

RUN apt-get --yes install ruby-dev build-essential
RUN gem install --no-ri --no-rdoc fpm
RUN apt-get update && apt-get install -y environment-modules
RUN apt-get update && apt-get install -y uuid-dev
RUN apt-get update && apt-get install -y libperl-dev
