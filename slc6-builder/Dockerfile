FROM centos:centos6

# Patch redhat-release: pretend to be SLC6
COPY mock-redhat-release-slc6.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc6.sh /bin/uname

RUN                                                                                         \
  rpm --rebuilddb                                                                        && \
  yum clean all                                                                          && \
  rpm --import http://apt.sw.be/RPM-GPG-KEY.dag.txt                                      && \
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
      libyaml-devel libffi-devel iconv-devel environment-modules                         && \
  yum install -y git --enablerepo=rpmforge-extras                                        && \
  yum clean all                                                                          && \
  pip install bernhard

RUN curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip

ENV CCTOOLS_VER 5.3.0
RUN curl http://ccl.cse.nd.edu/software/files/cctools-$CCTOOLS_VER-x86_64-redhat6.tar.gz |  \
    tar -C / --strip-components=1 -xzf - &&                                                 \
    ldconfig

RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3 && \
    curl -L get.rvm.io | bash -s stable                        && \
    bash -c "                                                     \
      source /etc/profile.d/rvm.sh && rvm install 2.3.0        && \
      rvm use 2.3.0 --default                                  && \
      gem install --no-ri --no-rdoc fpm"

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
CMD [ "bash" ]
