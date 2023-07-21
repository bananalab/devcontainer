_scriptdir="$(dirname "$(realpath "$0")")"
source $_scriptdir/_lib

download_and_install_gomplate() {
  local _version=${1}
  local _repo="hairyhenderson/gomplate"
  local _archive_url=$(get_release_archive_url ${_repo} ${_version} "gomplate_$(get_kernel)-$(get_machine)$")
  curl -o "/usr/local/bin/gomplate" -sfL "${_archive_url}"
  chmod 755 /usr/local/bin/gomplate
}

download_and_install_gomplate ${GOMPLATE_VERSION}
