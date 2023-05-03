#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_tflint() {
  local _version=${1}
  local _repo="terraform-linters/tflint"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "tflint_$(get_kernel)_$(get_machine).zip")
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/tflint.zip" -sfL "${_archive_url}"
  pushd "${_tmpdir}"
    unzip tflint.zip
    chmod +x tflint
    mv tflint /usr/local/bin
  popd
  rm -rf ${_tmpdir}
}

download_and_install_tflint ${TFLINT_VERSION}