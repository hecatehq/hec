# hec

`hec` is the command-line client for Hecate Cloud.

This repository is a binary distribution channel only. It does not contain the
`hec` source code.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hec/main/install.sh | sh
```

The installer detects your OS and CPU architecture, downloads the latest
release asset from this repository, verifies it against the published checksum,
and installs `hec` into `~/.local/bin` by default.

To choose another install directory:

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hec/main/install.sh | HEC_INSTALL_DIR=/usr/local/bin sh
```

To install a specific version:

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hec/main/install.sh | HEC_VERSION=v0.1.0 sh
```

## Usage

```sh
hec login
hec deployments
hec open
hec update
hec self update
```

Run `hec --help` for the current command list.

## Update

```sh
hec self update
```

To install a specific CLI version:

```sh
hec self update --version v0.1.0-alpha.3
```

## Uninstall

```sh
hec self uninstall
```

For shell-only uninstall:

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hec/main/install.sh | HEC_UNINSTALL=1 sh
```

## License

`hec` is proprietary software. See [LICENSE](./LICENSE).
