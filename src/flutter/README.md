# Flutter

Installs a Flutter release (and its bundled Dart SDK) into the container. Also configures the Dart and Flutter VS Code extensions with the correct SDK paths.

## Usage

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/andy-todd-dev/devcontainer-features/flutter:1": {
            "version": "latest"
        }
    }
}
```

```bash
$ flutter --version

Flutter 3.x.x • channel stable ...
```

## Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `version` | string | `latest` | Flutter version to install, e.g. `3.29.3`. Resolves the current stable release when set to `latest`. |

## VS Code Configuration

The feature automatically applies the following — no manual configuration needed:

**Extensions installed:**
- [`Dart-Code.dart-code`](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- [`Dart-Code.flutter`](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)

**Settings applied:**
```json
{
    "dart.sdkPath": "/usr/local/flutter_sdk/bin/cache/dart-sdk",
    "flutter.sdkPath": "/usr/local/flutter_sdk"
}
```
