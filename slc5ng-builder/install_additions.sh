#!/bin/bash -e
ALTPREFIX=${ALTPREFIX:-/opt/local}
TMPPREFIX=/tmp/alt
NJ=$(grep -c bogomips /proc/cpuinfo)

mkdir -p $ALTPREFIX $TMPPREFIX

export PATH=$ALTPREFIX/bin:$PATH
export LD_LIBRARY_PATH=$ALTPREFIX/lib64:$ALTPREFIX/lib:$LD_LIBRARY_PATH

cd $TMPPREFIX

wget --no-check-certificate https://www.openssl.org/source/openssl-1.0.2n.tar.gz
wget http://www.linuxfromscratch.org/patches/blfs/svn/openssl-1.0.2n-compat_versioned_symbols-1.patch
tar xzf openssl*.tar.gz
pushd openssl-1.0.2n
  patch -Np1 -i ../openssl-1.0.2n-compat_versioned_symbols-1.patch
  ./config --prefix=${ALTPREFIX} --openssldir=${ALTPREFIX}/etc/ssl --libdir=lib shared zlib-dynamic
  make depend
  make
  make install
popd

wget --no-check-certificate https://curl.mirror.anstey.ca/curl-7.58.0.tar.gz
tar xzf curl*.tar.gz
pushd curl-7.58.0
  ./configure --with-ssl=${ALTPREFIX} --prefix=${ALTPREFIX}
  make -j${NJ}
  make install
popd

wget --no-check-certificate https://www.kernel.org/pub/software/scm/git/git-1.9.5.tar.gz
tar xzf git*.tar.gz
pushd git-1.9.5
  ./configure --prefix=${ALTPREFIX} --with-openssl=${ALTPREFIX} --with-curl=${ALTPREFIX}
  make -j${NJ}
  make install
popd

cd /
rm -rf $TMPPREFIX
