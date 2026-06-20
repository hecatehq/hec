#!/usr/bin/env sh
set -eu

repo="${HEC_INSTALL_REPO:-hecatehq/hec}"
version="${HEC_VERSION:-latest}"
install_dir="${HEC_INSTALL_DIR:-${HOME:-.}/.local/bin}"

case "$(printf '%s' "${HEC_UNINSTALL:-}" | tr '[:upper:]' '[:lower:]')" in
  1 | true | yes | on)
    rm -f "${install_dir}/hec"
    echo "hec removed from ${install_dir}/hec"
    exit 0
    ;;
esac

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "hec installer needs '$1' on PATH" >&2
    exit 2
  fi
}

download() {
  url="$1"
  output="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$output"
    return
  fi
  if command -v wget >/dev/null 2>&1; then
    wget -q "$url" -O "$output"
    return
  fi
  echo "hec installer needs curl or wget on PATH" >&2
  exit 2
}

case "$(uname -s)" in
  Darwin) os="darwin" ;;
  Linux) os="linux" ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 2
    ;;
esac

case "$(uname -m)" in
  x86_64 | amd64) arch="amd64" ;;
  arm64 | aarch64) arch="arm64" ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 2
    ;;
esac

need tar
need awk
need install

asset="hec_${os}_${arch}.tar.gz"
checksums="hec_checksums.txt"

if [ "$version" = "latest" ]; then
  base_url="https://github.com/${repo}/releases/latest/download"
else
  base_url="https://github.com/${repo}/releases/download/${version}"
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT INT TERM

download "${base_url}/${asset}" "${tmp_dir}/${asset}"
download "${base_url}/${checksums}" "${tmp_dir}/${checksums}"

expected="$(awk -v asset="$asset" '$2 == asset { print $1; exit }' "${tmp_dir}/${checksums}")"
if [ -z "$expected" ]; then
  echo "Checksum for ${asset} was not found in ${checksums}" >&2
  exit 2
fi

if command -v sha256sum >/dev/null 2>&1; then
  actual="$(sha256sum "${tmp_dir}/${asset}" | awk '{print $1}')"
else
  need shasum
  actual="$(shasum -a 256 "${tmp_dir}/${asset}" | awk '{print $1}')"
fi

if [ "$actual" != "$expected" ]; then
  echo "Checksum mismatch for ${asset}" >&2
  exit 2
fi

tar -xzf "${tmp_dir}/${asset}" -C "$tmp_dir"
mkdir -p "$install_dir"
install -m 0755 "${tmp_dir}/hec" "${install_dir}/hec"

echo "hec installed to ${install_dir}/hec"
case ":$PATH:" in
  *":${install_dir}:"*) ;;
  *) echo "Add ${install_dir} to PATH if hec is not found by your shell." ;;
esac
