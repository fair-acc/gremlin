#!/usr/bin/env bash
# Vendors a gr4-present web viewer into talks/viewer/<commit>/, which GitHub Pages serves beside the decks:
#
#   scripts/update_viewer.sh [latest|vX.Y.Z] [minimal|full]          (default: latest minimal)
#
#   https://fair-acc.github.io/gremlin/talks/viewer/<commit>/?presentation=../../<talk>
#
# Downloads gr4-present-web-<flavour>-<version>.tar.gz from the gr4-present releases, checks it against the release's
# SHA256SUMS, and keeps the viewer only (no stub deck, no start scripts), with VERSION saying where it came from. The
# page names this site, not gr4-present's, as its address (as gr4-present's deck-site action does).
#
# The folder is named after the commit the viewer was built from, so a deck keeps the viewer it was checked with and a
# newer one goes beside it: name it as `viewer:` in the talk's zenodo.yml once the deck looks right in it (export the
# PDFs with a native build of the same commit), and remove a folder once no talk names it. minimal suffices for a deck
# without live charts; full (~60 MB) adds live GNU Radio 4 and OpenDigitizer.
set -euo pipefail
version=${1:-latest}
flavour=${2:-minimal}
repository=RalphSteinhagen/gr4-present
site=https://fair-acc.github.io/gremlin/talks/viewer
[[ "$version" =~ ^(latest|v[0-9]+\.[0-9]+\.[0-9]+)$ && "$flavour" =~ ^(minimal|full)$ ]] || {
  sed -n '2,15p' "$0"
  exit 2
}
root="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"
name="gr4-present-web-${flavour}-${version}"

# the commit the release tag points to (`latest` moves with main)
commit=$(git ls-remote "https://github.com/${repository}" "refs/tags/${version}^{}" "refs/tags/${version}" | awk 'NR==1 {print $1}')
[[ "$commit" =~ ^[0-9a-f]{40}$ ]] || {
  echo "no release tag ${version} in ${repository}" >&2
  exit 1
}
short=${commit:0:7}
target="$root/talks/viewer/$short"
[[ ! -e "$target" ]] || {
  echo "talks/viewer/$short exists: that build is vendored already" >&2
  exit 1
}

work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
base="https://github.com/${repository}/releases/download/${version}"
curl -fsSL --retry 3 -o "$work/$name.tar.gz" "$base/$name.tar.gz"
curl -fsSL --retry 3 -o "$work/SHA256SUMS" "$base/SHA256SUMS"
(cd "$work" && grep -E "  ${name}\.tar\.gz\$" SHA256SUMS | sha256sum -c -)
sha=$(sha256sum "$work/$name.tar.gz" | cut -d' ' -f1)
# `latest` is rebuilt in place: the tag may have moved between the lookup above and the download
[[ "$version" != latest ]] || [[ "$(git ls-remote "https://github.com/${repository}" refs/tags/latest | cut -f1)" == "$commit" ]] || {
  echo "the latest release moved during the download; run again" >&2
  exit 1
}

tar -xzf "$work/$name.tar.gz" -C "$work"
mkdir -p "$target"
for file in index.html index.js index.wasm gr4-serviceworker.js manifest.webmanifest icon.png; do
  cp "$work/$name/$file" "$target/"
done
sed -i "s|<meta name=\"gr4-site\" content=\"[^\"]*\" />|<meta name=\"gr4-site\" content=\"${site}/${short}/\" />|" "$target/index.html"
grep -q "content=\"${site}/${short}/\"" "$target/index.html" || {
  echo "index.html has no gr4-site address to replace; check the archive's page" >&2
  exit 1
}
cat >"$target/VERSION" <<EOF
gr4-present web viewer (${flavour}), vendored by scripts/update_viewer.sh on $(date -u +%F)
release: ${version}  https://github.com/${repository}/releases/tag/${version}
commit:  ${commit}  https://github.com/${repository}/commit/${commit}
archive: ${name}.tar.gz  sha256 ${sha}
licence: GPL-3.0-or-later (LICENSES/GPL-3.0-or-later.txt), (C) R. J. Steinhagen, GSI/FAIR
EOF
echo "talks/viewer/$short: the $flavour viewer $version ($commit), $(du -sh "$target" | cut -f1)"
echo "name it in a talk's zenodo.yml (viewer: \"$short\") once the deck looks right in it"
