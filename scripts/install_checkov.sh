#!/bin/bash -uex
if [ ${CHECKOV_VERSION} == "latest" ]; then
    PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install checkov
else
    PIPX_HOME=/opt/pipx PIPX_BIN_DIR=/usr/local/bin pipx install checkov~=${CHECKOV_VERSION}
fi