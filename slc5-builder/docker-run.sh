#!/bin/bash

#
# Run the slc5-builder container with the GAR wrapper.
#

cd "$(dirname "$0")"

Container='alisw/slc5-builder:latest'
PackagesDirHost="${HOME}/alisw/packages"
PackagesDirGuest='/packages_spool'
CcacheDirHost="${HOME}/alisw/ccache/slc5-builder"
CcacheDirGuest='/ccache'
BuilderHost="$( cd ${PWD}/../.. ; pwd )/ali-bot/build-ib.sh"
BuilderGuest='/build-ib.sh'
RecipeSvnCreds="$( cat "${PWD}/recipe-svn-creds.txt" 2> /dev/null )"
RecipeSvnUser=${RecipeSvnCreds%%:*}
RecipeSvnPassword=${RecipeSvnCreds#*:}

mkdir -p "$PackagesDirHost" "$CcacheDirHost"

exec time docker run -it --rm \
  -v "${BuilderHost}:${BuilderGuest}:ro" \
  -v "${PackagesDirHost}:${PackagesDirGuest}:rw" \
  -v "${CcacheDirHost}:${CcacheDirGuest}:rw" \
  -e 'PS1=`[ $? == 0 ] || echo $?\|`'$Container' ~ \u@\h \w \$> ' \
  -e "CCACHE_DIR=${CcacheDirGuest}" \
  -e "HOME=/root" \
  -e "DEFAULT_RECIPE_USER=${RecipeSvnUser}" \
  -e "DEFAULT_RECIPE_PASS=${RecipeSvnPassword}" \
  "$Container" \
  "$BuilderGuest" "$@"
