#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'android-sdk' Feature with no options.
#
# The value of all options will fall back to the default value in the
# Feature's 'devcontainer-feature.json'.
#
# This test can be run with the following command:
#
#    devcontainer features test    \
#               --features android-sdk \
#               --remote-user root \
#               --skip-scenarios   \
#               --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#               /path/to/this/repo

set -e

source dev-container-features-test-lib

check "sdkmanager version" sdkmanager --version
check "ANDROID_SDK_ROOT is set" [ -n "$ANDROID_SDK_ROOT" ]
check "platform tools exist" [ -d "$ANDROID_SDK_ROOT/platform-tools" ]
check "build tools exist" [ -d "$ANDROID_SDK_ROOT/build-tools" ]

reportResults
