#!/bin/zsh -e
printf "NOTICE: This container has Parrot for CVMFS. Enter a shell with Parrot with: parrot_run zsh\n" >&2
[[ -d $PARROT_CVMFS_ALIEN_CACHE ]] || \
  { printf "WARNING: CVMFS cache disabled. Mount a Docker volume to $PARROT_CVMFS_ALIEN_CACHE to enable it.\n" >&2;
    unset PARROT_CVMFS_ALIEN_CACHE; }
exec "$@"
