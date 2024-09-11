#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_helm() {
  local _version=${1}
  local _repo="helm/helm"
  if [ "${_version}" == "latest" ]; then
    _version="$(get_latest ${_repo})"
  fi
  local _archive_url=https://get.helm.sh/helm-v${_version//v}-$(get_kernel)-$(get_machine).tar.gz
  local _tmpdir=$(mktemp -d)
  rm ~/.curlrc
  curl -o "${_tmpdir}/helm.tar.gz" -fL "${_archive_url}"
  pushd "${_tmpdir}"
    tar -xf helm.tar.gz
    chmod +x */helm
    mv */helm /usr/local/bin/helm
  popd
  rm -rf "${_tmpdir}"
}

download_and_install_helm ${HELM_VERSION}
