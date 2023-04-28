#!/bin/sh
# vim:sw=4:ts=4:et

env

export BUILD_CMD=buildongithubactions

set -e

export IS_LATEST=true
make $BUILD_CMD
