#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'dart' Feature with no options.
#
# The value of all options will fall back to the default value in the
# Feature's 'devcontainer-feature.json' — i.e. version="latest", channel="stable".
#
# This test can be run with the following command:
#
#    devcontainer features test  \
#               --features dart  \
#               --remote-user root \
#               --skip-scenarios   \
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#               /path/to/this/repo

set -e

source dev-container-features-test-lib

check "dart version" dart --version
check "dart on PATH" which dart

reportResults
