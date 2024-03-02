#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_k9s() {
  local _version=${1}
  local _repo="derailed/k9s"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "k9s_$(tc $(get_kernel))_$(get_machine).tar.gz\$" )
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/k9s.tar.gz" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    tar -xf k9s.tar.gz
    mv k9s /usr/local/bin/k9s
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_k9s ${K9S_VERSION}
