#!/bin/bash -uex
if [ ${DIRENV_VERSION} == "latest" ]; then
    curl -sfL "https://direnv.net/install.sh" | bash
else
    curl -sfL "https://direnv.net/install.sh" | version=${DIRENV_VERSION} bash
fi

cat << EOF > /tmp/yourfilehere
[whitelist]
prefix = [ "/workspaces/" ]
EOF