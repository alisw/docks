from centos:centos6
ADD build.sh /build.sh
RUN /build.sh

ENTRYPOINT ["/proot", "-R", "/centos-7.2.1511-aarch64-rootfs", "-b", "/cvmfs:/cvmfs", "-b", "/build:/build", "-q", "/qemu-aarch64 -cpu cortex-a57"]
CMD ""
