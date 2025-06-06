#!/usr/bin/bash
set -exo pipefail

pacman -Syu --noconfirm
pacman -S --noconfirm git python3 python-pip which gcc \
                      make gcc-fortran \
                      base-devel libxpm libxft glu gsl \
                      libuv tbb xerces-c re2 libwebsockets grpc rsync
