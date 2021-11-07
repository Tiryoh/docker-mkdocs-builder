#!/bin/bash -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0})/../../; pwd)

generate_changelog() {
    if [ $(git tag -l "v$1") ]; then
        echo "git tag exists. re-generating CHANGELOG.md"
        git-chglog > CHANGELOG.md
    else
        git tag v$1
        mv CHANGELOG.md CHANGELOG.md.bak
        cat <(git-chglog v$1)  <(cat CHANGELOG.md.bak | grep -v "\[Unreleased\]" | grep -v 'name="unreleased"') > CHANGELOG.md
        rm CHANGELOG.md.bak
        git tag -d v$1 > /dev/null
    fi
}

if [[ "$1" == "" ]]; then
    echo Specify release version.
    echo eg: bash ./.github/scripts/update_changelog.sh 0.7.0
    exit 1
fi

cd $SRC_DIR
git checkout master
git pull origin master --tags
if [[ -z "$(git tag -l)" ]]; then
    echo no tags found
    exit 1
fi
generate_changelog $1
