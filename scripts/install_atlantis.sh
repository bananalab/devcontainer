#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_atlantis() {
  local _version=${1}
  local _repo="runatlantis/atlantis"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "atlantis_$(get_kernel)_$(get_machine).zip")
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/atlantis.zip" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    unzip atlantis.zip
    chmod +x atlantis
    mv atlantis /usr/local/bin/atlantis
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_atlantis ${ATLANTIS_VERSION}
