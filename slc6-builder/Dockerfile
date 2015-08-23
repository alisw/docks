# alisw/slc6-builder:v14

FROM centos:centos6

# Patch redhat-release: pretend to be SLC6
COPY mock-redhat-release-slc6.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc6.sh /bin/uname

# We need RPMforge for ccache
RUN \
  rpm --rebuilddb && \
  yum clean all && \
  yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm && \
  yum install -y autoconf automake bc bzip2 bzip2-devel ccache cmake compat-libstdc++-33 curl \
  cvs e2fsprogs e2fsprogs-libs file gcc-c++ gcc-gfortran git gmp gmp-devel java-1.7.0-openjdk \
  libX11-devel libXext-devel libXft-devel libXmu libXpm libXpm-devel libtool libxml2-devel make \
  mesa-libGLU-devel mpfr mpfr-devel openssl-devel perl-ExtUtils-Embed perl-libwww-perl python-devel \
  python-yaml redhat-lsb rpm-build screen subversion tcl tcsh tk wget which zip zlib-devel zsh \
  compat-libgfortran-41 python-argparse zip flex bison texinfo glibc-devel.i686 libgcc.i686 \
  glibc-devel.x86_64 libgcc.i686 libgcc.x86_64 ncurses-devel libcurl-devel expat expat-devel \
  vim-enhanced valgrind gdb swig && \
  yum clean all && \
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
  cd / && \
  rm -rf /tmp/cmake
