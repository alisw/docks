SLC6 builder for ALICE software
===============================

This repository contains all the needed information to build and run a
SLC6-compatible Docker container for compiling ALICE software.


Content
-------

* `Dockerfile`: definition of the Docker image
* `mock-uname-slc6.sh`: emulates the output of `uname` of a real SLC6 box
* `mock-redhat-release-slc6.txt`: tweaks the output of `lsb_release` to resemble
  a real SLC6 box


Container features
------------------

Based on `centos:centos6`. Special features:

* Build tools installed
* RPMforge (needed for ccache)
* ccache enabled by default
