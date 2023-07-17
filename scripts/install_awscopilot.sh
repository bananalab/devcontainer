#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_awscopilot() {
  local _version=${1}
  local _repo="aws/copilot-cli"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "copilot-$(get_kernel)-$(get_machine)-${_version}\$")
  curl -o "/usr/local/bin/copilot" -fL "${_archive_url}"
  chmod +x /usr/local/bin/copilot
}

download_and_install_awscopilot ${AWSCOPILOT_VERSION}
