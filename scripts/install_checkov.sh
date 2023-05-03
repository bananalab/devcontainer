#!/bin/bash -uex
if [ ${CHECKOV_VERSION} == "latest" ]; then
    pip install checkov
else
    pip install checkov~=${CHECKOV_VERSION}
fi