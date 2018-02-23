#!groovy

node("docker-light") {

  stage "Verify author"
  def power_users = ["ktf", "dberzano"]
  def deployable_branches = ["master"]
  echo "Changeset from " + env.CHANGE_AUTHOR
  if (power_users.contains(env.CHANGE_AUTHOR)) {
    echo "PR comes from power user. Testing"
  } else if(deployable_branches.contains(env.BRANCH_NAME)) {
    echo "Building master branch."
  } else {
    input "Do you want to test this change?"
  }

  stage "Build containers"
  wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
    withEnv([ "BRANCH_NAME=${env.BRANCH_NAME}",
              "CHANGE_TARGET=${env.CHANGE_TARGET}"]) {
      dir ("docks") {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
                          credentialsId: '75206d40-8dcf-4f44-aea4-e3a32bc201b3',
                          usernameVariable: 'DOCK_USER',
                          passwordVariable: 'DOCK_PASSWORD']]) {
          retry(2) {
            timeout(900) {
              checkout scm
              sh '''
                set -e
                set -o pipefail
                packer version
                GIT_DIFF_SRC="origin/$CHANGE_TARGET"
                [[ $CHANGE_TARGET == null || -z $CHANGE_TARGET ]] && GIT_DIFF_SRC="HEAD^"
                IMAGES=`git diff --name-only $GIT_DIFF_SRC.. | (grep / || true) | sed -e 's|/.*||' | uniq`

                case $BRANCH_NAME in
                  master) DOCKER_HUB_REPO=alisw    ;;
                  *)      DOCKER_HUB_REPO=aliswdev ;;
                esac


                export PACKER_LOG=1
                export PACKER_LOG_PATH=$PWD/packer.log
                mkdir -p /build/packer && [[ -d /build/packer ]]
                export TMPDIR=$(mktemp -d /build/packer/packer-XXXXX)
                export HOME=$TMPDIR
                yes | docker login -u "$DOCK_USER" -p "$DOCK_PASSWORD" || true
                unset DOCK_USER DOCK_PASSWORD

                for x in $IMAGES ; do
                  if ! test -f $x/packer.json ; then
                    echo "Image $x does not use Packer, skipping test."
                    continue
                  elif grep DOCKER_HUB_REPO "$x/packer.json" ; then
                    pushd "$x"
                     /usr/bin/packer build -var "DOCKER_HUB_REPO=${DOCKER_HUB_REPO}" packer.json || { cat $PACKER_LOG_PATH; false; }
                     echo "Image $x built successfully and uploaded as $DOCKER_HUB_REPO/$x"
                    popd
                  else
                    echo "$x/packer.json does not use DOCKER_HUB_REPO."
                    exit 1
                  fi
                done
              '''
            }
          }
        }
      }
    }
  }
}
