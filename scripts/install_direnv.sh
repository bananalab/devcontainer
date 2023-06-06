#!/bin/bash -uex
if [ ${DIRENV_VERSION} == "latest" ]; then
    curl -sfL "https://direnv.net/install.sh" | bash
else
    curl -sfL "https://direnv.net/install.sh" | version=${DIRENV_VERSION} bash
fi

mkdir -p /etc/skel/.config/direnv

cat << EOF > /etc/skel/.config/direnv/direnv.toml
[whitelist]
prefix = [ "/workspaces/" ]
EOF