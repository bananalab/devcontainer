#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_tfsec() {
  local _version=${1}
  local _repo="aquasecurity/tfsec"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "tfsec-$(get_kernel)-$(get_machine)"$ )
  curl -o "/usr/local/bin/tfsec" -fL "${_archive_url}"
  chmod +x /usr/local/bin/tfsec
}

download_and_install_tfsec ${TFSEC_VERSION}
