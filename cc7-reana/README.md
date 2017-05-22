ALICE container for REANA
=========================

Purpose of this container is to make it possible to reproduce a certain ALICE
analysis with no external requirements. The container will be created with a
certain AliPhysics version and all of its dependencies automatically. To build
it:

    docker build . --build-arg ALIPHYSICS_VERSION=vAN-20170101-1 -t aliphysics-van-20170101-1

where `ALIPHYSICS_VERSION` can be obtained by looking at the [list of published
packages](http://alimonitor.cern.ch/packages/?packagename=AliPhysics).

To run it:

    docker run -it --rm aliphysics-van-20170101-1

This will drop you to a shell with the appropriate environment already set. If
you want to preserve your data after exiting the container, use the `-v`
parameter:

    docker run -it --rm -v $HOME/foo:/foo aliphysics-van-20170101-1

Everything you write in `/foo` inside the container will be available outside
the container under `~/foo`.
