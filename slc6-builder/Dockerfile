# alisw/slc6-builder:v15

FROM centos:centos6

# Patch redhat-release: pretend to be SLC6
COPY mock-redhat-release-slc6.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc6.sh /bin/uname

RUN                                                                                                  \
  rpm --rebuilddb &&                                                                                 \
  yum clean all &&                                                                                   \
  yum install -y autoconf automake bc bzip2 bzip2-devel compat-libstdc++-33 curl                     \
  cvs e2fsprogs e2fsprogs-libs file gcc-c++ gcc-gfortran git gmp gmp-devel java-1.7.0-openjdk        \
  libX11-devel libXext-devel libXft-devel libXmu libXpm libXpm-devel libtool libxml2-devel make      \
  mesa-libGLU-devel mpfr mpfr-devel openssl-devel perl-ExtUtils-Embed perl-libwww-perl python-devel  \
  python-yaml redhat-lsb rpm-build screen subversion tcl tcsh tk wget which zip zlib-devel zsh       \
  compat-libgfortran-41 python-argparse flex bison texinfo glibc-devel.i686 libgcc.i686              \
  glibc-devel.x86_64 libgcc.i686 libgcc.x86_64 ncurses-devel libcurl-devel expat expat-devel         \
  apr-devel subversion-devel cyrus-sasl-md5                                                          \
  vim-enhanced valgrind gdb swig &&                                                                  \
  yum clean all
RUN rpm --rebuilddb && yum install -y rubygems ruby-devel
RUN gem install --no-ri --no-rdoc fpm
RUN rpm --rebuilddb &&                                                                                       \
    rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt &&                                                     \
    yum install -y http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm &&  \
    yum install -y git --enablerepo=rpmforge-extras
RUN rpm --rebuilddb && yum install -y environment-modules
RUN rpm --rebuilddb && yum install -y libuuid-devel

ENV CCTOOLS_VER 5.3.0
RUN curl http://ccl.cse.nd.edu/software/files/cctools-$CCTOOLS_VER-x86_64-redhat6.tar.gz |  \
    tar -C / --strip-components=1 -xzf - &&                                                 \
    ldconfig
