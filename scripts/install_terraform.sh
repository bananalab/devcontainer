#!/bin/bash -uex
_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_tfenv() {
  local _version=${1}
  local _repo="tfutils/tfenv"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} 'tarball')
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/tfenv.tar.gz" -sfL "${_archive_url}"
  pushd ${_tmpdir}
    tar -xf tfenv.tar.gz
    mkdir -p /opt/tfenv
    mv ${_tmpdir}/tfutils-tfenv-*/* /opt/tfenv
    ln -s /opt/tfenv/bin/* /usr/local/bin
  popd
  rm -rf ${_tmpdir}
  mkdir -p /opt/tfenv/versions
  chmod 777 /opt/tfenv/versions
  tfenv install ${TERRAFORM_VERSION}
  tfenv use ${TERRAFORM_VERSION}
  chmod 777 /opt/tfenv/version  
}

download_and_install_tfenv ${TFENV_VERSION}