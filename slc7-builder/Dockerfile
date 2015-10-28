# alisw/slc7-builder:v8

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
    autoconf libxml2-devel openssl-devel libcurl-devel bzip2-devel mesa-libGLU-devel zip \
    perl-libwww-perl svn cvs flex bison texinfo glibc-devel.i686 glibc-devel.x86_64 libgcc.i686 \
    libgcc.x86_64 ncurses-devel vim-enhanced gdb valgrind swig
RUN yum install -y rubygems ruby-devel
RUN gem install --no-ri --no-rdoc fpm
RUN yum install -y environment-modules
