#!/bin/bash

#
# Run the slc5-builder container with the GAR wrapper.
#

cd "$(dirname "$0")"

Container='slc5-builder'
PackagesDirHost="${HOME}/alisw/packages"
PackagesDirGuest='/opt/aliroot/www/tarballs'
CcacheDirHost="${HOME}/alisw/ccache/slc5-builder"
CcacheDirGuest='/ccache'
BuilderHost="${PWD}/wrap-gar-build.sh"
BuilderGuest='/wrap-gar-build.sh'

mkdir -p "$PackagesDirHost" "$CcacheDirHost"

exec time docker run -it --rm \
  -v "${BuilderHost}:${BuilderGuest}:ro" \
  -v "${PackagesDirHost}:${PackagesDirGuest}:rw" \
  -v "${CcacheDirHost}:${CcacheDirGuest}:rw" \
  -e 'PS1=`[ $? == 0 ] || echo $?\|`'$Container' ~ \w \u@\h \$> ' \
  -e "CCACHE_DIR=${CcacheDirGuest}" \
  -e "HOME=/root" \
  "$Container" \
  "$BuilderGuest" \
    --software root \
    --recipe-version v5-06-25-01 \
    --recipe-svn-user alibits \
    --recipe-svn-password xxxxxxxx
