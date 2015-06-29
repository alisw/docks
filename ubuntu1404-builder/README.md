Ubuntu 14.04 LTS builder for ALICE software
===========================================

This repository contains all the needed information to build and run an Ubuntu
14.04 container for compiling ALICE software.


Content
-------

* `Dockerfile`: definition of the Docker image
* `mock-uname-ubuntu1404.sh`: emulates the output of `uname` of a real Ubuntu
   14.04 box


Container features
------------------

Based on `ubuntu:14.04`. Special features:

* Build tools installed
* ccache enabled by default
