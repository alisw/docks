#!/bin/sh -ex

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

yum install -y epel-release dnf-plugins-core
yum config-manager --set-enabled powertools
yum update -y
yum groups install -y 'Development Tools'
yum install -y bc e2fsprogs                                        \
               e2fsprogs-libs git java-1.8.0-openjdk libXmu libXpm \
               perl-ExtUtils-Embed rpm-build screen tcl tcsh tk    \
               wget which zsh gcc gcc-gfortran gcc-c++             \
               libX11-devel libXpm-devel libXft-devel              \
               libXext-devel redhat-lsb libtool automake autoconf  \
               libxml2-devel openssl-devel libcurl-devel           \
               bzip2-devel mesa-libGLU-devel zip perl-libwww-perl  \
               svn cvs flex bison texinfo glibc-devel.i686         \
               glibc-devel.x86_64 libgcc.i686 libgcc.x86_64        \
               ncurses-devel vim-enhanced gdb valgrind swig        \
               apr-devel subversion-devel cyrus-sasl-md5 rubygems  \
               ruby-devel uuid-devel environment-modules           \
               python3-requests libuuid-devel createrepo           \
               protobuf-devel python3-pip python3-devel            \
               mariadb-devel kernel-devel pciutils-devel           \
               kmod-devel motif motif-devel pigz glew-devel        \
               numactl-devel doxygen graphviz glfw-devel           \
               zlib-devel readline-devel openssh-server            \
               libglvnd-opengl tk-devel libfabric-devel sshpass    \
               xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps   \
               python2 python2-devel rsync libXrandr-devel         \
               libXi-devel libXcursor-devel libXinerama-devel      \
               gettext-devel rclone s3cmd apr-util-devel           \
               cyrus-sasl-devel python3-pyyaml

alternatives --set python /usr/bin/python3

wipeyum

gem install --no-document fpm

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
