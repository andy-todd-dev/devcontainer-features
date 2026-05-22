#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'flutter' Feature with no options.
#
# The value of all options will fall back to the default value in the
# Feature's 'devcontainer-feature.json' — i.e. version="latest".
#
# This test can be run with the following command:
#
#    devcontainer features test    \
#               --features flutter \
#               --remote-user root \
#               --skip-scenarios   \
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#               /path/to/this/repo

set -e

source dev-container-features-test-lib

check "flutter version" flutter --version
check "dart version" dart --version

reportResults
