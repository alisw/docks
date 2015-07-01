FROM centos:centos7

#ADD RPM-GPG-KEY-cern /etc/pki/rpm-gpg/RPM-GPG-KEY-cern
#ADD HEP_OSlibs.repo /etc/yum.repos.d/HEP_OSlibs.repo

#RUN yum update -y && yum install -y HEP_OSlibs_SL6
RUN yum update -y && yum install -y PyYAML bc compat-libstdc++-33 e2fsprogs e2fsprogs-libs git java-1.7.0-openjdk libXmu libXpm perl-ExtUtils-Embed rpm-build screen tcl tcsh tk wget which zsh gcc
RUN yum update -y && yum install -y cmake gcc-gfortran gcc-c++ libX11-devel libXpm-devel libXft-devel libXext-devel redhat-lsb
RUN yum update -y && yum install -y libtool automake autoconf libxml2-devel openssl-devel libcurl-devel bzip2-devel mesa-libGLU-devel

RUN yum install -y zip perl-libwww-perl svn cvs

# Patch redhat-release: pretend to be SLC6
COPY mock-redhat-release-slc7.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc7.sh /bin/uname
