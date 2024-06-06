#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_e1s() {
  local _version=${1}
  local _repo="keidarcy/e1s"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "e1s_${_version//v}_$(get_kernel)_$(get_machine).tar.gz")
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/e1s.tar.gz" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    tar -xf e1s.tar.gz
    chmod +x e1s
    mv e1s /usr/local/bin/e1s
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_e1s ${AWSCOPILOT_VERSION}
