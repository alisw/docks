# alisw/ubuntu1404-builder:v4

FROM ubuntu:14.04

# Patch uname
COPY mock-uname-ubuntu1404.sh /bin/uname

# No extra repos needed
RUN                                                                                                                   \
  apt-get --yes --force-yes update                                                                                 && \
  apt-get install --yes --force-yes                                                                                   \
    curl build-essential gfortran                                                                                     \
    subversion wget libmysqlclient-dev xorg-dev libglu1-mesa-dev                                                      \
    libfftw3-dev libssl-dev libxml2-dev libtool automake git unzip                                                    \
    libcgal-dev libmpfr4 libmpfr-dev libcgal10 libcgal-dev openjdk-7-jre                                              \
    bc time libbz2-dev python-dev python-yaml libcurl4-openssl-dev flex                                               \
    bison swig screen tcl libtcl8.5 tk zip unzip zsh texinfo libncurses5-dev                                          \
    environment-modules libperl-dev                                                                                   \
    vim-nox valgrind gdb python-pip ruby-dev build-essential                                                       && \
  apt-get --yes --force-yes clean                                                                                  && \
  pip install bernhard

RUN gem install --no-ri --no-rdoc fpm
RUN curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip && \
    unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip
