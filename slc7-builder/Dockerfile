# alisw/slc7-builder:v5

FROM centos:centos7

# Patch redhat-release: pretend to be SLC7
COPY mock-redhat-release-slc7.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc7.sh /bin/uname

RUN \
  rpmdb --rebuilddb && \
  yum clean all && \
  yum install -y PyYAML bc compat-libstdc++-33 e2fsprogs e2fsprogs-libs git java-1.7.0-openjdk \
    libXmu libXpm perl-ExtUtils-Embed rpm-build screen tcl tcsh tk wget which zsh gcc gcc-gfortran \
    gcc-c++ libX11-devel libXpm-devel libXft-devel libXext-devel redhat-lsb libtool automake \
    autoconf libxml2-devel ccache openssl-devel libcurl-devel bzip2-devel mesa-libGLU-devel zip \
    perl-libwww-perl svn cvs flex bison texinfo glibc-devel.i686 glibc-devel.x86_64 libgcc.i686 \
    libgcc.x86_64 ncurses-devel && \
  ln -nfs /usr/bin/ccache /usr/local/bin/gcc && \
  ln -nfs /usr/bin/ccache /usr/local/bin/g++ && \
  ln -nfs /usr/bin/ccache /usr/local/bin/cc && \
  ln -nfs /usr/bin/ccache /usr/local/bin/c++ && \
  mkdir /tmp/cmake && \
  cd /tmp/cmake && \
  wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz && \
  tar xzf *.tar.gz && \
  cd cmake-2.8.12 && \
  ./bootstrap && \
  make -j$( grep -c bogomips /proc/cpuinfo ) install && \
  rm -rf /tmp/cmake
