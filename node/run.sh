#!/bin/bash -e
[[ -z $GH_REPO ]] && { echo "Specify environment variable GH_REPO in the form org/repo:ref."; exit 1; }
GH_BRANCH=${GH_REPO##*:}
GH_REPO=${GH_REPO%:*}
git clone https://github.com/$GH_REPO -b $GH_BRANCH /src
cd /src
npm install
npm start
