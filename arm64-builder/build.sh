#!/bin/sh -ex
curl -O http://davidlt.web.cern.ch/davidlt/vault/proot/qemu-aarch64
curl -O http://eulisse.web.cern.ch/eulisse/centos-7.2.1511-aarch64-rootfs.tgz
curl -O http://davidlt.web.cern.ch/davidlt/vault/proot/proot
tar xzvf centos-7.2.1511-aarch64-rootfs.tgz
rm -fr centos-7.2.1511-aarch64-rootfs.tar*

chmod +x /qemu-aarch64
mkdir -p /cvmfs /build

chmod +x /proot
