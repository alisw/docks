SLC5 builder for ALICE software
===============================

This repository contains all the needed information to build and run a
SLC5-compatible Docker container for compiling ALICE software.


Content
-------

* `Dockerfile`: definition of the Docker image
* `wrap-gar-build.sh`: script steering the old GAR build system inside the
  container
* `fake-uname-slc5.sh`: emulates the output of `uname` on a real SLC5 box
* `docker-run.sh`: example command to run the container for building


Container features
------------------

Based on `centos:5`. Special features:

* Build tools installed
* RPMforge (needed for Git)
* CMake v2.8 installed manually
* ccache enabled by default


Containers and GAR
------------------

The old ALICE build system is based on GAR. Software recipes are stored on a
private SVN repository (requires authentication):

```
https://svn.cern.ch/reps/aliroot-bits/branches/[recipe_name]
```

We provide a script, `wrap-gar-build.sh`, that makes the container capable of
building from a GAR recipe.

Output files are tarballs written in a packages destination directory, that
should be shared as a Docker volume with the host: please refer to the
`docker-run.sh` example.
