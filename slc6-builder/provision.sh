#!/bin/sh -ex

# CERN key is needed as we switched to the CERN mirror in
# /etc/yum.repos.d/CentOS-Base.repo (installed separately)
curl -fL https://linuxsoft.cern.ch/cern/slc6X/x86_64/RPM-GPG-KEY-cern -o /etc/pki/rpm-gpg/RPM-GPG-KEY-cern
# The mirror for this is not available any more. We don't need it anyway.
rm -v /etc/yum.repos.d/CentOS-fasttrack.repo
# Install extra repos
yum install -y https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/epel-release-6-8.noarch.rpm \
    http://mirror1.hs-esslingen.de/repoforge/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm
# Repos for CVMFS and XRootD
curl -fL http://cvmrepo.web.cern.ch/cvmrepo/yum/RPM-GPG-KEY-CernVM -o /etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM
curl -fL http://cvmrepo.web.cern.ch/cvmrepo/yum/cernvm.repo -o /etc/yum.repos.d/cernvm.repo
curl -fL http://xrootd.org/binaries/xrootd-stable-slc6.repo -o /etc/yum.repos.d/xrootd.repo

rpm --rebuilddb
yum clean all
yum upgrade -y

# This works around an annoying breakage when trying to update plymouth, because
# the repo only has plymouth-core-libs-0.8.3-29.el6.x86_64, while we have
# plymouth-core-libs-0.8.3-29.el6.centos.x86_64 installed. The latter is
# considered later than the one we need, so downgrade.
yum downgrade -y plymouth-core-libs-0.8.3-29.el6.x86_64

yum install -y autoconf automake bc bzip2 bzip2-devel gcc-gfortran gmp gmp-devel \
    java-1.7.0-openjdk libX11-devel libXext-devel libXft-devel libXmu libXpm     \
    libXpm-devel libtool libxml2-devel make mesa-libGLU-devel mpfr mpfr-devel    \
    openssl-devel perl-ExtUtils-Embed perl-libwww-perl redhat-lsb rpm-build      \
    screen subversion tcl tcsh tk wget which zip zlib-devel zsh flex bison       \
    texinfo glibc-devel.i686 libgcc.i686 glibc-devel.x86_64 libgcc.i686          \
    libgcc.x86_64 compat-libgfortran-41 ncurses-devel libcurl-devel expat        \
    compat-libstdc++-33 curl cvs e2fsprogs e2fsprogs-libs file gcc-c++           \
    uuid-devel expat-devel apr-devel subversion-devel cyrus-sasl-md5 file-devel  \
    vim-enhanced valgrind gdb swig protobuf-devel glibc-static libxml2-static    \
    openssl-static zlib zlib-static patch readline readline-devel libyaml-devel  \
    libffi-devel environment-modules tk-devel realpath cvmfs eos-client          \
    1:xrootd-client-4.12.5-1.el6.x86_64 1:xrootd-libs-4.12.5-1.el6.x86_64        \
    1:xrootd-client-libs-4.12.5-1.el6.x86_64
# Above: we need old versions of xrootd for compatibility with eos-client.

yum install -y git --enablerepo=rpmforge-extras
yum clean all

curl -fL https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o /tmp/vault.zip
unzip /tmp/vault.zip vault -d /usr/bin/
rm -vf /tmp/vault.zip

curl -fL "http://ccl.cse.nd.edu/software/files/cctools-$CCTOOLS_VERSION-x86_64-redhat6.tar.gz" |
  tar --strip-components=1 -xzC /
ldconfig

# Install Python 3.6.8 then 2.7, the same versions as on slc7 and slc8.
# Install python2 after python3 to get pip -> pip2 and python -> python2 links.
for pyver in "$PYTHON3_VERSION" "$PYTHON2_VERSION"; do
  [ -n "$pyver" ] || continue
  pymajor=${pyver%%.*} pymajmin=${pyver%.*}
  mkdir -vp /tmp/py
  cd /tmp/py
  curl -fL "https://www.python.org/ftp/python/$pyver/Python-$pyver.tgz" |
    tar --strip-components=1 -xz
  ./configure --prefix=/usr/local
  make -j 16
  make install
  # `make install` doesn't create /usr/local/bin/python, so do that ourselves.
  ln -svf "python$pymajor" /usr/local/bin/python
  # If we're using an old python version, we need to get an old pip.
  curl -fLO "https://bootstrap.pypa.io/pip/$pymajmin/get-pip.py" ||
    # That sort of versioned URL isn't available for supported python versions,
    # so use the default one if the versioned one doesn't resolve.
    curl -fLO "https://bootstrap.pypa.io/pip/get-pip.py"
  "/usr/local/bin/python$pymajmin" get-pip.py
  cd /
  rm -rf /tmp/py
  "pip$pymajor" install requests
done
