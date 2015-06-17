FROM centos:centos6

# Patch redhat-release: pretend to be SLC6
COPY mock-redhat-release-slc6.txt /etc/redhat-release

# Patch uname
COPY mock-uname-slc6.sh /bin/uname

#ADD RPM-GPG-KEY-cern /etc/pki/rpm-gpg/RPM-GPG-KEY-cern
#ADD HEP_OSlibs.repo /etc/yum.repos.d/HEP_OSlibs.repo

#RUN yum update -y && yum install -y HEP_OSlibs_SL6

RUN yum install -y bc compat-libstdc++-33 e2fsprogs e2fsprogs-libs git java-1.7.0-openjdk libXmu libXpm perl-ExtUtils-Embed rpm-build screen tcl tcsh tk wget which zsh

RUN yum install -y zip perl-libwww-perl svn cvs
