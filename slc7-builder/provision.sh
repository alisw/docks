groupadd -g 980 mesosalien
useradd -u 980 -g 980 mesosalien
groupadd -g 981 mesosci
useradd -u 981 -g 981 mesosci
groupadd -g 982 mesosdaq
useradd -u 982 -g 982 mesosdaq
groupadd -g 983 mesosuser
useradd -u 983 -g 983 mesosuser
groupadd -g 984 mesostest
useradd -u 984 -g 984 mesostest

rpmdb --rebuilddb && yum clean all && rm -rf /var/cache/yum
yum install -y http://mirror.switch.ch/ftp/mirror/epel/epel-release-latest-7.noarch.rpm
yum update -y

yum install -y centos-release-scl
yum-config-manager --enable rhel-server-rhscl-7-rpms
yum install -y rh-git218 rh-ruby23-ruby-devel
cat << \EOF > /etc/profile.d/enable-alice.sh
source scl_source enable rh-git218
source scl_source enable rh-ruby23
EOF


yum groupinstall -y 'Development Tools'
yum groupinstall -y 'X Window System'

yum install -y PyYAML bc compat-libstdc++-33 e2fsprogs             \
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
               mariadb-devel kernel-devel pciutils-devel           \
               kmod-devel motif motif-devel                        \
               numactl-devel doxygen graphviz glfw-devel           \
               zlib-devel readline-devel openssh-server            \
               libglvnd-opengl tk-devel libfabric-devel sshpass    \
               gettext-devel

rpmdb --rebuilddb && yum clean all && rm -rf /var/cache/yum

source scl_source enable rh-git218
source scl_source enable rh-ruby23
gem install --no-ri --no-rdoc fpm

curl -L https://github.com/cooperative-computing-lab/cctools/archive/release/{{user `CCTOOLS_VERSION`}}.tar.gz -o cctools.tar.gz
mkdir cctools && cd cctools
tar --strip-components=1 -xzf ../cctools.tar.gz
./configure --prefix=/usr/local && make -j10 && make install
cd ..
rm -rf cctools*
ldconfig
which work_queue_worker

curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip
unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip
