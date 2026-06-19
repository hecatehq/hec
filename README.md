# hcloud

`hcloud` is the command-line client for Hecate Cloud.

This repository is a binary distribution channel only. It does not contain the
`hcloud` source code.

## Install

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hcloud/main/install.sh | sh
```

The installer detects your OS and CPU architecture, downloads the latest
release asset from this repository, verifies it against the published checksum,
and installs `hcloud` into `~/.local/bin` by default.

To choose another install directory:

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hcloud/main/install.sh | HCLOUD_INSTALL_DIR=/usr/local/bin sh
```

To install a specific version:

```sh
curl -fsSL https://raw.githubusercontent.com/hecatehq/hcloud/main/install.sh | HCLOUD_VERSION=v0.1.0 sh
```

## Usage

```sh
hcloud login
hcloud deployments
hcloud deployment open --deployment my-hecate
```

Run `hcloud --help` for the current command list.

## License

`hcloud` is proprietary software. See [LICENSE](./LICENSE).
