FROM ubuntu:15.10

COPY mock-uname-ubuntu1510.sh /bin/uname

RUN \
  apt-get --yes --force-yes update && \
  apt-get install --yes --force-yes curl build-essential gfortran subversion wget \
    libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libssl-dev libxml2-dev libtool \
    automake git unzip openjdk-7-jre bc time libbz2-dev python-dev python-yaml \
    libcurl4-openssl-dev flex bison screen tcl tk zip unzip zsh texinfo libncurses5-dev vim-nox \
    valgrind gdb inetutils-ping && \
  apt-get --yes --force-yes clean
