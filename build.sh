#!/bin/sh
# vim:sw=4:ts=4:et

export BUILD_CMD=pushtodockerhub

set -e

export IS_LATEST=true
make $BUILD_CMD
