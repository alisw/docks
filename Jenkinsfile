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
          master) DOCKER_TAG=latest ;;
          *) DOCKER_TAG=devel ;;
        esac

        for x in $IMAGES ; do
          if grep docker_tag "$x/packer.json" ; then
            packer build -var "docker_tag=${DOCKER_TAG}" "$x/packer.json"
          else
            echo "$x/packer.json does not use docker_tag"
            exit 1
          fi
        done
      '''
    }
  }
}
