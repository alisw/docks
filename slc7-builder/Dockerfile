FROM centos:centos7

#ADD RPM-GPG-KEY-cern /etc/pki/rpm-gpg/RPM-GPG-KEY-cern
#ADD HEP_OSlibs.repo /etc/yum.repos.d/HEP_OSlibs.repo

#RUN yum update -y && yum install -y HEP_OSlibs_SL6

RUN yum update -y && yum install -y PyYAML bc compat-libstdc++-33 e2fsprogs e2fsprogs-libs git java-1.7.0-openjdk libXmu libXpm perl-ExtUtils-Embed rpm-build screen tcl tcsh tk wget which zsh gcc
RUN yum update -y && yum install -y cmake gcc-gfortran gcc-c++ libX11-devel libXpm-devel libXft-devel libXext-devel

RUN yum install -y zip perl-libwww-perl svn cvs
