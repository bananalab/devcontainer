#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_eksctl() {
  local _version=${1}
  local _repo="weaveworks/eksctl"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "eksctl_$(tc $(get_kernel))_$(get_machine).tar.gz" )
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/eksctl.tar.gz" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    tar -xf eksctl.tar.gz
    chmod +x eksctl
    mv eksctl /usr/local/bin/eksctl
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_eksctl ${EKSCTL_VERSION}
