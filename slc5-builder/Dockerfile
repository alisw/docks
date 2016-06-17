# alisw/slc5-builder:v12

FROM centos:5

# Patch uname
COPY mock-uname-slc5.sh /bin/uname

# Patch redhat-release
COPY mock-redhat-release-slc5.txt /etc/redhat-release

# Operations:
# - Install RPMforge (needed for git)
# - Install some required packages
RUN                                                                                                                                    \
  rpmdb --rebuilddb                                                                                                                &&  \
  yum clean all                                                                                                                    &&  \
  yum install -y wget                                                                                                              &&  \
  mkdir /tmp/rpmforge && cd /tmp/rpmforge                                                                                          &&  \
  rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt                                                                                &&  \
  wget http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm                                       &&  \
  yum install -y rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm                                                                        &&  \
  cd / && rm -rf /tmp/rpmforge                                                                                                     &&  \
  yum install -y subversion install autoconf automake libtool                                                                          \
  zlib-devel libxml2-devel openssl-devel gcc-c++ gcc-gfortran                                                                          \
  make libX11-devel libXpm-devel libXft-devel libXext-devel                                                                            \
  mesa-libGLU-devel git curl bzip2 which file redhat-lsb bzip2-devel                                                                   \
  python-devel gmp gmp-devel java-1.7.0-openjdk python-yaml                                                                            \
  zip flex bison texinfo glibc-devel.i686 glibc-devel.x86_64                                                                           \
  libgcc.i686 libgcc.x86_64 ncurses-devel expat expat-devel curl-devel                                                                 \
  python-setuptools python-hashlib tcl valgrind gdb vim-enhanced                                                                       \
  libaio libaio-devel doxygen unzip libtermcap-devel                                                                               &&  \
  wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-5.noarch.rpm                                                      &&  \
  rpm -Uvh epel-release*                                                                                                           &&  \
  yum install -y python26                                                                                                          &&  \
  ln -s /usr/bin/python2.6 /usr/local/bin/python                                                                                   &&  \
  curl https://bootstrap.pypa.io/get-pip.py | python                                                                               &&  \
  pip install bernhard                                                                                                             &&  \
  pip install pyyaml                                                                                                               &&  \
  yum clean all                                                                                                                    &&  \
  easy_install argparse
RUN rpm --rebuilddb && yum install -y environment-modules
RUN rm -f /var/lib/rpm/Pubkeys && rpm --rebuilddb && yum install -y mysql-devel
ADD https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip vault.zip
RUN unzip vault.zip && mv ./vault /usr/bin/vault
