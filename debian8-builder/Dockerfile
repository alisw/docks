FROM debian:8

RUN                                                                            \
  apt-get --yes --force-yes update                                          && \
  apt-get install --yes --force-yes                                            \
    automake bc bison build-essential curl environment-modules flex gdb        \
    gfortran git libbz2-dev libcurl4-openssl-dev libfftw3-dev                  \
    libglu1-mesa-dev libmysqlclient-dev libncurses5-dev libperl-dev            \
    libssl-dev libtcl8.5 libtool libxml2-dev openjdk-7-jre python-dev          \
    python-pip python-yaml ruby ruby-dev screen subversion swig tcl texinfo    \
    time tk unzip valgrind vim-nox wget xorg-dev zip zsh                    && \
  apt-get --yes --force-yes clean                                           && \
  pip install bernhard

RUN gem install --no-ri --no-rdoc fpm
RUN curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip
