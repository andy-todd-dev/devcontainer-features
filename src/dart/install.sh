#!/bin/sh
set -e

VERSION=${VERSION:-"latest"}
CHANNEL=${CHANNEL:-"stable"}
DART_INSTALL_DIR="/usr/local/dart-sdk"

if [ "$(id -u)" -ne 0 ]; then
    echo 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
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

check_packages curl unzip ca-certificates jq

# Detect CPU architecture and map to Dart's naming
case "$(dpkg --print-architecture)" in
    amd64) ARCH="x64" ;;
    arm64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $(dpkg --print-architecture)" >&2; exit 1 ;;
esac

if [ "${VERSION}" = "latest" ]; then
    VERSION=$(curl -s "https://storage.googleapis.com/dart-archive/channels/${CHANNEL}/release/latest/VERSION" \
        | jq -r '.version')
fi

echo "(*) Installing Dart SDK version ${VERSION} (channel: ${CHANNEL}, arch: ${ARCH})..."

curl -LO "https://storage.googleapis.com/dart-archive/channels/${CHANNEL}/release/${VERSION}/sdk/dartsdk-linux-${ARCH}-release.zip" \
    && unzip -q "dartsdk-linux-${ARCH}-release.zip" -d /usr/local \
    && rm "dartsdk-linux-${ARCH}-release.zip"

# Ensure all users can read and execute the SDK
chmod -R a+rX "${DART_INSTALL_DIR}"

# Clean up
rm -rf /var/lib/apt/lists/*

echo "Done!"
