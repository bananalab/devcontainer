#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_terraform_docs() {
  local _version=${1}
  local _repo="terraform-docs/terraform-docs"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "terraform-docs-${_version}-$(get_kernel)-$(get_machine).tar.gz")
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/terraform-docs.tar.gz" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    tar -xf terraform-docs.tar.gz
    chmod +x terraform-docs
    mv terraform-docs /usr/local/bin
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_terraform_docs ${TERRAFORM_DOCS_VERSION}