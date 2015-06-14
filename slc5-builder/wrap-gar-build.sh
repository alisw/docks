#!/bin/bash

#
# Build a given version of a software handled by GAR.
#
# Usage:
#   wrap-gar-build.sh --software <software_name> \
#                     --recipe-version <recipe_version> \
#                     --recipe-svn-user <recipe_svn_user> \
#                     --recipe-svn-password <recipe_svn_password>
#
# Example:
#   wrap-gar-build.sh --software root --recipe-version v5-06-25 \
#     --recipe-svn-user alibits --recipe-svn-password xxxxxx
#
# At the end of the process packages will be stored as tarballs inside two
# directories, $RegisterTarballsDir and $FinalTarballsDir.
#

# Exit at first error and make sure we are not inside a specific dir
set -x
set -e
cd /

while [[ $# -gt 0 ]] ; do
  case "$1" in
    --software) RecipeSw="$2" ; shift 2 ;;
    --recipe-version) RecipeVer="$2" ; shift 2 ;;
    --recipe-svn-user) RecipeSvnUser="$2" ; shift 2 ;;
    --recipe-svn-password) RecipeSvnPassword="$2" ; shift 2 ;;
    *) shift ;;
  esac
done

# Mandatory input variables
[[ "$RecipeVer" == '' || "$RecipeSw" == '' ]] && false
[[ "$RecipeSvnUser" == '' || "$RecipeSvnPassword" == '' ]] && false

# Other variables
RecipeUrl="https://svn.cern.ch/reps/aliroot-bits/branches/${RecipeVer}"
RecipeDir='/root/recipe'
BuildScratchDir='/root/scratch'
WwwDir='/opt/aliroot/www'
AltWwwDir='/root/www'
FinalTarballsDir="${WwwDir}/tarballs"  # *all* tarballs created
RegisterTarballsDir='/packages_spool'  # only tarballs to be registered
MakeCores=$( echo 'scale=2;a='`grep -c bogomips /proc/cpuinfo`'*1.05;scale=0;a/1' | bc )

# Start from a clean slate (do not touch tarball dirs)
rm -rf "$BuildScratchDir" "$RecipeDir" "$AltTarballsDir"

# Directories expected by the build system
mkdir -p "$RegisterTarballsDir" "$FinalTarballsDir"

# Work around hardcoded paths
ln -nfs "$WwwDir" "$AltWwwDir"

# Download recipe
svn checkout "$RecipeUrl" "$RecipeDir" \
  --username "$RecipeSvnUser" \
  --password "$RecipeSvnPassword" \
  --non-interactive

# Configure GAR, the build recipes handler
cd "$RecipeDir"
./bootstrap
./configure --prefix="$BuildScratchDir"

# Build AliRoot Core
cd "${RecipeDir}/apps/aliroot/aliroot"

# Build a specific software on all possible cores
cd "${RecipeDir}/apps/${RecipeSw}/${RecipeSw}"
exec time make -j"$MakeCores" install AUTOREGISTER=0 BUILD_ARGS=-j"$MakeCores"
