#!groovy

node {

  stage "Verify author"
  def power_users = ["ktf", "dberzano"]
  def deployable_branches = ["master"]
  echo "Changeset from " + env.CHANGE_AUTHOR
  if (power_users.contains(env.CHANGE_AUTHOR)) {
    echo "PR comes from power user. Testing"
  } else if(deployable_branches.containers(env.BRANCH_NAME)) {
    echo "Building master branch."
  } else {
    input "Do you want to test this change?"
  }

  stage "Build containers"
  withEnv([
        "BRANCH_NAME=${env.BRANCH_NAME}",
        "CHANGE_TARGET=${env.CHANGE_TARGET}"]) {
    dir ("docks") {
      checkout scm
      sh '''
        IMAGES=`git diff --name-only origin/${CHANGE_TARGET}.. | grep '/' | sed -e 's|/.*||' | uniq`

        case $BRANCH_NAME in
          master) DOCKER_HUB_REPO=alisw    ;;
          *)      DOCKER_HUB_REPO=aliswdev ;;
        esac

        for x in $IMAGES ; do
          if ! test -f $x/packer.json ; then
            echo "Image $x does not use Packer, skipping test."
            continue
          elif grep DOCKER_HUB_REPO "$x/packer.json" ; then
            packer build -var "DOCKER_HUB_REPO=${DOCKER_HUB_REPO}" "$x/packer.json"
          else
            echo "$x/packer.json does not use DOCKER_HUB_REPO."
            exit 1
          fi
        done
      '''
    }
  }
}
