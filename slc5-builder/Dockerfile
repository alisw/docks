# alisw/slc5-builder:v12

FROM centos:5

# Patch uname
COPY mock-uname-slc5.sh /bin/uname

# Patch redhat-release
COPY mock-redhat-release-slc5.txt /etc/redhat-release

# Operations:
# - Install RPMforge (needed for git)
# - Install some required packages
RUN \
  rpmdb --rebuilddb && \
  yum clean all && \
  yum install -y wget && \
  mkdir /tmp/rpmforge && cd /tmp/rpmforge && \
  rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt && \
  wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm && \
  yum install -y rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm && \
  cd / && rm -rf /tmp/rpmforge && \
  yum install -y subversion install autoconf automake libtool zlib-devel libxml2-devel \
    openssl-devel gcc-c++ gcc-gfortran make libX11-devel libXpm-devel libXft-devel libXext-devel \
    mesa-libGLU-devel git curl bzip2 which file redhat-lsb bzip2-devel python-devel gmp gmp-devel \
    java-1.7.0-openjdk python-yaml zip flex bison texinfo glibc-devel.i686 \
    glibc-devel.x86_64 libgcc.i686 libgcc.x86_64 ncurses-devel expat expat-devel curl-devel \
    python-setuptools python-hashlib tcl valgrind gdb vim-enhanced libaio libaio-devel doxygen && \
  mkdir /tmp/rpmswig && cd /tmp/rpmswig && \
  wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/Openwsman/RedHat_RHEL-5/x86_64/swig-3.0.2-5.1.x86_64.rpm && \
  yum localinstall -y --nogpgcheck swig-3.0.2-5.1.x86_64.rpm && \
  cd / && rm -rf /tmp/rpmswig && \
  yum clean all && \
  easy_install argparse
