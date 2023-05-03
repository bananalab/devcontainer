#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_sops() {
  local _version=${1}
  local _repo="mozilla/sops"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "sops-${_version}.$(get_kernel).$(get_machine)")
  curl -o "/usr/local/bin/sops" -fL "${_archive_url}"
  chmod +x /usr/local/bin/sops
}

download_and_install_sops ${SOPS_VERSION}
