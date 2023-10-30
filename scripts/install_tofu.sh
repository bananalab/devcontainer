#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_tofu() {
  local _version=${1}
  local _repo="opentofu/opentofu"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "tofu_${_version:1}_$(get_kernel)_$(get_machine)" )
  _tmpdir=$(mktemp -d)
  pushd ${_tmpdir}
  curl -o "tofu.zip" -fL "${_archive_url}"
  unzip tofu.zip
  chmod +x tofu
  mv tofu /usr/local/bin/tofu
  popd
  rm -rf ${_tmpdir}
}

download_and_install_tofu ${TOFU_VERSION}
