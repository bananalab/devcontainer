#!/bin/bash -uex
if [ ${PRECOMMIT_VERSION} == "latest" ]; then
    PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install pre-commit
else
    PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install pre-commit~=${PRECOMMIT_VERSION}
fi