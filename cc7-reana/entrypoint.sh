#!/bin/bash -e
exec /cvmfs/alice.cern.ch/bin/alienv setenv AliPhysics/$ALIPHYSICS_VERSION -c $*
