# alisw/slc7-builder:v8

FROM centos:centos7

# Patch redhat-release: pretend to be SLC7
COPY mock-redhat-release-slc7.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc7.sh /bin/uname

RUN                                                                                               \
  rpmdb --rebuilddb                                                                           &&  \
  yum clean all                                                                               &&  \
  yum install -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm  &&  \
  yum update -y                                                                               &&  \
  yum install -y PyYAML bc compat-libstdc++-33 e2fsprogs                                          \
        e2fsprogs-libs git java-1.7.0-openjdk libXmu libXpm                                       \
        perl-ExtUtils-Embed rpm-build screen tcl tcsh tk wget which zsh                           \
        gcc gcc-gfortran gcc-c++ libX11-devel libXpm-devel libXft-devel                           \
        libXext-devel redhat-lsb libtool automake autoconf libxml2-devel                          \
        openssl-devel libcurl-devel bzip2-devel mesa-libGLU-devel zip                             \
        perl-libwww-perl svn cvs flex bison texinfo glibc-devel.i686                              \
        glibc-devel.x86_64 libgcc.i686 libgcc.x86_64 ncurses-devel                                \
        vim-enhanced gdb valgrind swig apr-devel subversion-devel                                 \
        cyrus-sasl-md5 rubygems ruby-devel fpm uuid-devel environment-modules                     \
        python-requests libuuid-devel createrepo protobuf-devel python-pip                    &&  \
  yum clean all

RUN pip install --upgrade pip six && pip install bernhard
RUN gem install --no-ri --no-rdoc fpm
RUN curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip
RUN curl -L http://repo1.maven.org/maven2/com/madgag/bfg/1.12.8/bfg-1.12.8.jar -o /usr/local/lib/bfg.jar && \
    printf "#!/bin/sh\nexec java -jar /usr/local/lib/bfg.jar\n" > /usr/local/bin/bfg                     && \
    chmod +x /usr/local/bin/bfg
