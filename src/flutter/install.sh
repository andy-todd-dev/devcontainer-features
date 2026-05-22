#!/bin/sh
set -e

VERSION=${VERSION:-"latest"}
FLUTTER_INSTALL_DIR="/usr/local/flutter_sdk"

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Clean up
rm -rf /var/lib/apt/lists/*

apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

export DEBIAN_FRONTEND=noninteractive

check_packages curl git unzip xz-utils zip libglu1-mesa ca-certificates jq

if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -s https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json \
        | jq -r '.current_release.stable as $h | .releases[] | select(.hash == $h) | .version')
fi

install() {

    curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${VERSION}-stable.tar.xz \
    && tar xf flutter_linux_${VERSION}-stable.tar.xz \
    && mv flutter ${FLUTTER_INSTALL_DIR} \
    && git config --system --add safe.directory ${FLUTTER_INSTALL_DIR} \
    && rm flutter_linux_${VERSION}-stable.tar.xz \
    && rm -rf ${FLUTTER_INSTALL_DIR}/.pub-cache ${FLUTTER_INSTALL_DIR}/bin/cache/downloads

}

echo "(*) Installing Flutter version ${VERSION}..."

install

# Allow all users to write to Flutter's cache directory.
# Flutter writes engine stamps and other files to bin/cache at runtime;
# without this, non-root users get "Permission denied" errors.
chmod -R a+rwX "${FLUTTER_INSTALL_DIR}/bin/cache"

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"