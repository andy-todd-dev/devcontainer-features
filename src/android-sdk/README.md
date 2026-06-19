# Android SDK

Installs the Android SDK into the container with configurable platform versions, build tools, NDK, and CMake.

## Usage

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/andy-todd-dev/devcontainer-features/android-sdk:1": {}
    }
}
```

Requires the Java feature to be installed first:

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/features/java:1": {},
        "ghcr.io/andy-todd-dev/devcontainer-features/android-sdk:1": {}
    }
}
```

Verify installation:

```bash
$ sdkmanager --list_installed
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `platformsVersion` | string | `34` | Android SDK platform version to install, e.g. `34`, `35`. |
| `buildToolsVersion` | string | `34.0.0` | Build tools version to install, e.g. `34.0.0`, `35.0.0`. |
| `installNdk` | boolean | `false` | Install the Android NDK (Native Development Kit). |
| `ndkVersion` | string | `26.1.10909125` | NDK version to install. |
| `installCmake` | boolean | `false` | Install CMake for native C++ development. |
| `cmakeVersion` | string | `3.22.1` | CMake version to install. Options: `3.6.4111459`, `3.10.2`, `3.18.1`, `3.22.1`. |

## Environment Variables

The feature sets the following environment variables:

- `ANDROID_SDK_ROOT`: `/usr/local/android`
- `ANDROID_HOME`: `/usr/local/android`
- `PATH`: Updated to include Android SDK tools

## Example with NDK and CMake

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/devcontainers/features/java:1": {},
        "ghcr.io/andy-todd-dev/devcontainer-features/android-sdk:1": {
            "platformsVersion": "35",
            "buildToolsVersion": "35.0.0",
            "installNdk": true,
            "ndkVersion": "26.1.10909125",
            "installCmake": true,
            "cmakeVersion": "3.22.1"
        }
    }
}
```
