#!/bin/sh -ex
/proot -R /fedora-22-ppc64le-rootfs -b /cvmfs:/cvmfs -b /build:/build -q "/qemu-ppc64le" $@
