#!/usr/bin/env bash
# Exports a gr4-present deck to the two PDFs its Zenodo record carries, outside the repository:
#
#   $TALK_PDFS/<talk>/<talk>_slides.pdf   one page per slide, at its last step (the handout)
#   $TALK_PDFS/<talk>/<talk>_steps.pdf    one page per step (as presented)
#   (default TALK_PDFS: ~/.cache/gremlin-talks)
#
#   scripts/talk_pdfs.sh talks/20261116_EU_GR_Days
#
# Run it when the talk is final and committed, check the PDFs, then `scripts/zenodo_talks.py upload talks/<talk>`
# puts them into the reserved Zenodo draft. The PDFs never enter git; export.stamp records the commit they show.
#
# The viewer is $GR4_PRESENT_BIN, else the newest cmake-build-*Release*/src/app/gr4-present in $GR4_PRESENT
# (default ~/git/gr4-present). Build it from a current checkout: an older viewer silently drops what it does not
# know yet (masters, pictures, attributes) and ignores the deck's `export: { dpi: 150 }` picture resolution in
# index.yml, which keeps the PDFs small.
set -euo pipefail
[ $# -eq 1 ] && [ -f "$1/index.yml" ] || { sed -n '2,17p' "$0"; exit 2; }
talk="$(cd "$1" && pwd)"
name="$(basename "$talk")"
root="$(git -C "$talk" rev-parse --show-toplevel)"
rel="${talk#"$root"/}"
out="${TALK_PDFS:-${XDG_CACHE_HOME:-$HOME/.cache}/gremlin-talks}/$name"
viewer="${GR4_PRESENT_BIN:-}"
if [ -z "$viewer" ]; then
  # shellcheck disable=SC2012 # build-directory names are plain
  viewer="$(ls -t "${GR4_PRESENT:-$HOME/git/gr4-present}"/cmake-build-*Release*/src/app/gr4-present 2>/dev/null | head -1)"
fi
[ -x "$viewer" ] || { echo "no gr4-present viewer; set GR4_PRESENT_BIN or GR4_PRESENT" >&2; exit 1; }
# the PDFs show the committed deck only when its tracked files match HEAD (README.md and zenodo.yml do not count)
state=clean
git -C "$root" diff --quiet HEAD -- "$rel" ":(exclude)$rel/README.md" ":(exclude)$rel/zenodo.yml" || state=dirty
[ "$state" = clean ] || echo "warning: $rel has uncommitted changes; these PDFs cannot be uploaded" >&2
echo "viewer: $viewer ($(date -r "$viewer" +%F))"
mkdir -p "$out"
rm -f "$out/export.stamp"
for mode in slides steps; do
  pdf="$out/${name}_${mode}.pdf"
  log="$(mktemp)"
  "$viewer" --presentation "$talk" --export "$mode" --export-to "$pdf" >"$log" 2>&1 || { cat "$log" >&2; exit 1; }
  # "stays a picture": a drawing embedded as pixels, not vectors; expected, so only counted
  echo "$pdf: $(pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/ {print $2}') pages, $(du -h "$pdf" | cut -f1)," \
    "$(grep -c 'stays a picture' "$log" || true) drawings as pictures"
  grep WARNING "$log" | grep -v 'stays a picture' | sed 's/^/  /' || true
  rm -f "$log"
done
echo "$(git -C "$root" rev-parse HEAD) $state" >"$out/export.stamp"
echo "check both PDFs, then: scripts/zenodo_talks.py upload $rel   (--sandbox for a trial)"
