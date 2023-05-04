#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_infracost() {
  local _version=${1}
  local _repo="infracost/infracost"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "infracost-$(get_kernel)-$(get_machine).tar.gz"$ )
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/infracost.tar.gz" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    tar -xf infracost.tar.gz
    mv infracost-$(get_kernel)-$(get_machine) /usr/local/bin/infracost
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_infracost ${INFRACOST_VERSION}
