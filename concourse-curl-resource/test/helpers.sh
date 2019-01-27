#!/bin/bash

set -e -u

set -o pipefail

export TMPDIR_ROOT=$(mktemp -d /tmp/concoure-curl-resource-tests.XXXXXX)
trap "rm -rf $TMPDIR_ROOT" EXIT

if [ -d /opt/resource ]; then
  resource_dir=/opt/resource
else
  resource_dir=$(cd $(dirname $0)/../assets && pwd)
fi

run() {
  export TMPDIR=$(mktemp -d ${TMPDIR_ROOT}/concoure-curl-resource-tests.XXXXXX)

  echo -e 'running '"$@"$'\e[0m...'
  eval "$@" 2>&1 | sed -e 's/^/  /g'
  echo ""
}

create_version_file() {
  local version=$1
  local src=$2

  mkdir $src/version
  echo "$version" > $src/version/number

  echo version/number
}
