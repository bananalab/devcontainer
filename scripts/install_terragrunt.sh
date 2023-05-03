#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_terragrunt() {
  local _version=${1}
  local _repo="gruntwork-io/terragrunt"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "terragrunt_$(get_kernel)_$(get_machine)")
  curl -o "/usr/local/bin/terragrunt" -fL "${_archive_url}"
  chmod +x /usr/local/bin/terragrunt
}

download_and_install_terragrunt ${TERRAGRUNT_VERSION}
