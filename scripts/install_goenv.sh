_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_goenv() {
  local _version=${1}
  local _repo="go-nv/goenv"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} 'tarball')
  local _tmpdir=$(mktemp -d)
  curl -o "${_tmpdir}/goenv.tar.gz" -sfL "${_archive_url}"
  pushd ${_tmpdir}
    tar -xf goenv.tar.gz
    mkdir -p /opt/goenv
    cp -r go-nv*/* /opt/goenv
    mkdir -p /opt/goenv/shims
    chmod 777 /opt/goenv/shims
    mkdir -p /opt/goenv/versions
    chmod 777 /opt/goenv/versions
    touch /opt/goenv/version
    chmod 777 /opt/goenv/version
    export GOENV_ROOT="/opt/goenv"
    /opt/goenv/bin/goenv install ${GO_VERSION}
    /opt/goenv/bin/goenv global $(/opt/goenv/bin/goenv versions )
  popd
  rm -rf ${_tmpdir}
}

download_and_install_goenv ${GOENV_VERSION}

cat <<- EOF > /etc/skel/.zshenv
    export GOENV_ROOT="/opt/goenv"
    path+=("/opt/goenv/bin")
    eval "\$(goenv init -)"
EOF