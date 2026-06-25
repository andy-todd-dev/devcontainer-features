# Dart

Installs the Dart SDK into the container. Also configures the Dart VS Code extension with the correct SDK path.

## Usage

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/andy-todd-dev/devcontainer-features/dart:1": {
            "version": "latest",
            "channel": "stable"
        }
    }
}
```

```bash
$ dart --version

Dart SDK version: 3.x.x (stable) ...
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `version` | string | `latest` | Dart SDK version to install, e.g. `3.5.0`. Resolves the current release for the chosen channel when set to `latest`. |
| `channel` | string | `stable` | Dart release channel: `stable`, `beta`, or `dev`. |

## VS Code Configuration

The feature automatically applies the following — no manual configuration needed:

**Extensions installed:**
- [`Dart-Code.dart-code`](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)

**Settings applied:**
```json
{
    "dart.sdkPath": "/usr/local/dart-sdk"
}
```
