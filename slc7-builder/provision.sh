#!/bin/bash -ex

useradd -rmUu 980 mesosalien
useradd -rmUu 981 mesosci
useradd -rmUu 982 mesosdaq
useradd -rmUu 983 mesosuser
useradd -rmUu 984 mesostest

wipeyum () {
  rpmdb --rebuilddb
  yum clean all
  rm -rf /var/cache/yum
}

wipeyum
yum install -y centos-release-scl http://mirror.switch.ch/ftp/mirror/epel/epel-release-latest-7.noarch.rpm
yum-config-manager --enable rhel-server-rhscl-7-rpms
yum update -y
yum groups install -y 'Development Tools' 'X Window System'
yum install -y rh-ruby23-ruby-devel                                \
               PyYAML bc compat-libstdc++-33 e2fsprogs             \
               e2fsprogs-libs git java-1.7.0-openjdk libXmu libXpm \
               perl-ExtUtils-Embed rpm-build screen tcl tcsh tk    \
               wget which zsh gcc gcc-gfortran gcc-c++             \
               libX11-devel libXpm-devel libXft-devel              \
               libXi-devel pigz                                    \
               libXext-devel redhat-lsb libtool automake autoconf  \
               libxml2-devel openssl-devel libcurl-devel           \
               bzip2-devel mesa-libGLU-devel zip perl-libwww-perl  \
               svn cvs flex bison texinfo glibc-devel.i686         \
               glibc-devel.x86_64 libgcc.i686 libgcc.x86_64        \
               ncurses-devel vim-enhanced gdb valgrind swig        \
               apr-devel subversion-devel cyrus-sasl-md5 rubygems  \
               ruby-devel uuid-devel environment-modules           \
               python-requests libuuid-devel createrepo            \
               protobuf-devel python-pip python-devel              \
               python3-pip python3-devel python3-requests          \
               mariadb-devel kernel-devel pciutils-devel           \
               kmod-devel motif motif-devel                        \
               numactl-devel doxygen graphviz glfw-devel           \
               zlib-devel readline-devel openssh-server            \
               libglvnd-opengl tk-devel libfabric-devel sshpass    \
               gettext-devel rclone s3cmd
wipeyum
cat << \EOF > /etc/profile.d/enable-alice.sh
source scl_source enable rh-ruby23
EOF

set +ex  # scl_source doesn't work with `set -e`
source scl_source enable rh-ruby23
set -ex

gem install --no-document fpm

mkdir /tmp/cctools
curl -fsSL "https://github.com/cooperative-computing-lab/cctools/archive/release/$CCTOOLS_VERSION.tar.gz" |
  tar --strip-components=1 -xzC /tmp/cctools
cd /tmp/cctools
./configure --prefix=/usr/local
make -j10
make install
cd /
rm -rf /tmp/cctools
ldconfig
which work_queue_worker

curl -Lo /tmp/vault.zip https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip
unzip /tmp/vault.zip vault -d /usr/bin/
rm -v /tmp/vault.zip

# A recent git version (>= 2.31.0) is required for specifying git config
# using environment variables.
curl -L "https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.xz" | tar -xJC /tmp
cd "/tmp/git-$GIT_VERSION"
make prefix=/usr/local -j 10 all
make prefix=/usr/local install
cd /
rm -rf "/tmp/git-$GIT_VERSION"
[ "$(git --version)" = "git version $GIT_VERSION" ]
