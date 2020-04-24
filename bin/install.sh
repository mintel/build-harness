#!/bin/bash
set -e

export BUILD_HARNESS_ORG=${1:-mintel}
export BUILD_HARNESS_PROJECT=${2:-build-harness}
export BUILD_HARNESS_BRANCH=${3:-master}
export BUILD_HARNESS_TAG=${4:-latest}
export GITHUB_REPO="https://github.com/${BUILD_HARNESS_ORG}/${BUILD_HARNESS_PROJECT}.git"

echo "Installing ${BUILD_HARNESS_PROJECT}..."

if [ "$BUILD_HARNESS_PROJECT" ] && [ -d "$BUILD_HARNESS_PROJECT" ]; then
  (cd $BUILD_HARNESS_PROJECT && git checkout $BUILD_HARNESS_BRANCH && git pull) >/dev/null 2>&1;
else
  echo "Cloning ${GITHUB_REPO}#${BUILD_HARNESS_BRANCH}"
  git clone -b $BUILD_HARNESS_BRANCH $GITHUB_REPO >/dev/null 2>&1
fi

if [ "$BUILD_HARNESS_PROJECT" ] && [ -d "$BUILD_HARNESS_PROJECT" ]; then
  cd $BUILD_HARNESS_PROJECT
  BUILD_HARNESS_LATEST_TAG=$(git describe --abbrev=0 --tags)
  if [ "$BUILD_HARNESS_TAG" == "latest" ]; then
    git reset --hard $BUILD_HARNESS_LATEST_TAG;
  else
    git reset --hard $BUILD_HARNESS_TAG
  fi
  echo "Using ${BUILD_HARNESS_PROJECT}/${BUILD_HARNESS_BRANCH}@$(git tag --points-at HEAD | paste -sd ',' -)"
fi
