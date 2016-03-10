#!/bin/sh -ex
curl -O http://davidlt.web.cern.ch/davidlt/vault/proot/qemu-aarch64
curl -O http://davidlt.web.cern.ch/davidlt/vault/proot/centos-7.2.1511-aarch64-rootfs.tar.bz2
tar xjvf centos-7.2.1511-aarch64-rootfs.tar.bz2
curl -O http://davidlt.web.cern.ch/davidlt/vault/proot/proot
chmod +x /proot
