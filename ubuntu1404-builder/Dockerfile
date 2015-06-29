FROM ubuntu:14.04

# Patch uname
COPY mock-uname-ubuntu1404.sh /bin/uname

# No extra repos needed
RUN \
  sed -i -e 's|http://archive.ubuntu.com/ubuntu/|mirror://mirrors.ubuntu.com/mirrors.txt|g' /etc/apt/sources.list && \
  apt-get --yes --force-yes update && \
  apt-get install --yes --force-yes curl build-essential gfortran subversion cmake ccache wget \
    libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libssl-dev libxml2-dev libtool \
    automake git unzip libcgal-dev libmpfr4 libmpfr-dev libcgal10 libcgal-dev openjdk-7-jre && \
  apt-get --yes --force-yes clean && \
  ln -nfs /usr/bin/ccache /usr/local/bin/gcc && \
  ln -nfs /usr/bin/ccache /usr/local/bin/g++ && \
  ln -nfs /usr/bin/ccache /usr/local/bin/cc && \
  ln -nfs /usr/bin/ccache /usr/local/bin/c++
