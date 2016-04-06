#!/bin/sh -ex
/proot -R /centos-7.2.1511-aarch64-rootfs -b /cvmfs:/cvmfs -b /build:/build -q "/qemu-aarch64 -cpu cortex-a57" $@
