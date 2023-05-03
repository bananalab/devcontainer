#!/bin/bash -uex
if [ ${PRECOMMIT_VERSION} == "latest" ]; then
    pip install pre-commit
else
    pip install pre-commit~=${PRECOMMIT_VERSION}
fi