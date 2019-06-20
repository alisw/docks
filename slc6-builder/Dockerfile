FROM centos:centos6

RUN \
  rpm --rebuilddb && \
  yum clean all && \
  yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm                                                 && \
  yum install -y http://mirror1.hs-esslingen.de/repoforge/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm && \
  yum install -y autoconf automake bc bzip2 bzip2-devel                                     \
      compat-libstdc++-33 curl cvs e2fsprogs e2fsprogs-libs file gcc-c++                    \
      gcc-gfortran git gmp gmp-devel java-1.7.0-openjdk libX11-devel                        \
      libXext-devel libXft-devel libXmu libXpm libXpm-devel libtool                         \
      libxml2-devel make mesa-libGLU-devel mpfr mpfr-devel openssl-devel                    \
      perl-ExtUtils-Embed perl-libwww-perl python-devel python-yaml                         \
      redhat-lsb rpm-build screen subversion tcl tcsh tk wget which zip                     \
      zlib-devel zsh compat-libgfortran-41 python-argparse flex bison                       \
      texinfo glibc-devel.i686 libgcc.i686 glibc-devel.x86_64 libgcc.i686                   \
      libgcc.x86_64 ncurses-devel libcurl-devel expat uuid-devel expat-devel                \
      apr-devel subversion-devel cyrus-sasl-md5 file-devel vim-enhanced                     \
      valgrind gdb swig python-pip protobuf-devel glibc-static libxml2-static               \
      openssl-static zlib zlib-static patch readline readline-devel                         \
      libyaml-devel libffi-devel iconv-devel environment-modules tk-devel                   \
      realpath                                                                           && \
  yum install -y git --enablerepo=rpmforge-extras                                        && \
  yum clean all                                                                          && \
  pip install bernhard

RUN curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip

ENV CCTOOLS_VER 6.2.9
RUN curl http://ccl.cse.nd.edu/software/files/cctools-$CCTOOLS_VER-x86_64-redhat6.tar.gz |  \
    tar -C / --strip-components=1 -xzf - &&                                                 \
    ldconfig

# Install CVMFS
RUN curl -L http://cvmrepo.web.cern.ch/cvmrepo/yum/RPM-GPG-KEY-CernVM > /etc/pki/rpm-gpg/RPM-GPG-KEY-CernVM && \
    curl -L http://cvmrepo.web.cern.ch/cvmrepo/yum/cernvm.repo > /etc/yum.repos.d/cernvm.repo && \
    rpm --rebuilddb && yum install -y cvmfs

# Install XRootD
RUN curl -L http://xrootd.org/binaries/xrootd-stable-slc6.repo > /etc/yum.repos.d/xrootd.repo && \
    rpm --rebuilddb && yum install -y xrootd-client

# Install EOS
COPY eos.repo /etc/yum.repos.d/eos.repo
RUN rpm --rebuilddb && yum install -y eos-client

# Parrot configuration
ENV PARROT_ALLOW_SWITCHING_CVMFS_REPOSITORIES=yes \
    PARROT_CVMFS_REPO=<default-repositories>\ alice-ocdb.cern.ch:url=http://cvmfs-stratum-one.cern.ch/cvmfs/alice-ocdb.cern.ch,pubkey=/etc/cvmfs/keys/cern.ch/cern-it1.cern.ch.pub \
    HTTP_PROXY=DIRECT; \
    PARROT_CVMFS_ALIEN_CACHE=/cvmfs_alien_cache

# Install Python 2.7
RUN mkdir -p /tmp/py                                                    && \
    cd /tmp/py                                                          && \
    curl -LO https://www.python.org/ftp/python/2.7.15/Python-2.7.15.tgz && \
    tar xzf Python*.tgz                                                 && \
    cd Python-2.7.15                                                    && \
    ./configure --prefix=/usr/local                                     && \
    make -j 16                                                          && \
    make install                                                        && \
    curl -LO curl -LO https://bootstrap.pypa.io/get-pip.py              && \
    /usr/local/bin/python get-pip.py                                    && \
    cd /                                                                && \
    rm -rf /tmp/py

# Install Python extras possibly needed
RUN which pip && pip install requests

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "bash" ]
