#!/usr/bin/env bash
set -euo pipefail

RELEASE_REPOSITORY="${MULTICA_RELEASE_REPOSITORY:-hduhelp/multica}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

tag="$(gh api "repos/$RELEASE_REPOSITORY/releases/latest" --jq .tag_name)"
version="${tag#v}"
if [[ -z "$version" || "$tag" != "v$version" ]]; then
  echo "unexpected release tag: $tag" >&2
  exit 1
fi

targets=(
  darwin-arm64
  darwin-amd64
  linux-arm64
  linux-amd64
)

for target in "${targets[@]}"; do
  asset="multica-cli-$version-$target.tar.gz"
  gh release download "$tag" \
    --repo "$RELEASE_REPOSITORY" \
    --pattern "$asset" \
    --dir "$TMP_DIR"
  if [[ ! -f "$TMP_DIR/$asset" ]]; then
    echo "release asset missing: $asset" >&2
    exit 1
  fi
done

sha256() {
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$1" | awk '{print $1}'
  else
    shasum -a 256 "$1" | awk '{print $1}'
  fi
}

darwin_arm64_sha="$(sha256 "$TMP_DIR/multica-cli-$version-darwin-arm64.tar.gz")"
darwin_amd64_sha="$(sha256 "$TMP_DIR/multica-cli-$version-darwin-amd64.tar.gz")"
linux_arm64_sha="$(sha256 "$TMP_DIR/multica-cli-$version-linux-arm64.tar.gz")"
linux_amd64_sha="$(sha256 "$TMP_DIR/multica-cli-$version-linux-amd64.tar.gz")"

mkdir -p "$ROOT_DIR/Formula"
sed \
  -e "s/@VERSION@/$version/g" \
  -e "s/@DARWIN_ARM64_SHA@/$darwin_arm64_sha/g" \
  -e "s/@DARWIN_AMD64_SHA@/$darwin_amd64_sha/g" \
  -e "s/@LINUX_ARM64_SHA@/$linux_arm64_sha/g" \
  -e "s/@LINUX_AMD64_SHA@/$linux_amd64_sha/g" \
  "$ROOT_DIR/scripts/multica.rb.template" >"$ROOT_DIR/Formula/multica.rb"

echo "Updated Formula/multica.rb to $tag"
