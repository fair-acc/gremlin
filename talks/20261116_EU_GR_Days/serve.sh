#!/usr/bin/env bash
# Serves this deck and opens it in a gr4-present viewer.
#
#   ./serve.sh            serve on port 8000, open the viewer
#   ./serve.sh -p 8010    another port
#   ./serve.sh --no-open  serve only
#
# The viewer, the first that exists: GR4_PRESENT_VIEWER (an address); the WASM-Minimal build of the gr4-present checkout
# in GR4_PRESENT (default ~/git/gr4-present); the copy the live slides use, ../viewer/<viewer: in zenodo.yml>/; the
# public https://ralphsteinhagen.github.io/gr4-present/minimal/. A local one is served on port 8080. The viewer reads
# the deck through devtools/serve.mjs --cors; Chrome asks once for "local network access" the first time it reads
# localhost. Tick "follow edits" in the viewer's side menu (Ctrl+O) to reload the deck when a file changes.
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
viewer="${GR4_PRESENT_VIEWER:-https://ralphsteinhagen.github.io/gr4-present/minimal/}"
port=8000
open=1
while [ $# -gt 0 ]; do
  case "$1" in
    -p|--port) port="$2"; shift 2 ;;
    --no-open) open=0; shift ;;
    -h|--help) sed -n '2,13p' "$0"; exit 0 ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
  esac
done
local_viewer="${GR4_PRESENT:-$HOME/git/gr4-present}/cmake-build-WASM-Minimal/viewer-web"
if [ ! -f "$local_viewer/index.html" ]; then
  build="$(sed -n 's/^viewer: *"\{0,1\}\([0-9a-f]*\)"\{0,1\}.*/\1/p' "${here}/zenodo.yml" 2>/dev/null)"
  local_viewer="${here}/../viewer/${build:-none}"
fi
if [ -z "${GR4_PRESENT_VIEWER:-}" ] && [ -f "$local_viewer/index.html" ]; then
  if ! curl -s "http://localhost:8080/index.html" >/dev/null; then
    node "${here}/devtools/serve.mjs" --no-browser --directory "$local_viewer" --port 8080 >/dev/null 2>&1 &
    trap 'kill $! 2>/dev/null' EXIT
  fi
  viewer="http://localhost:8080/"
fi
address="${viewer}?presentation=http://localhost:${port}"
echo "deck:   ${here}"
echo "viewer: ${address}"
if [ "$open" = 1 ]; then
  (sleep 1; xdg-open "$address" >/dev/null 2>&1 || true) &
fi
exec node "${here}/devtools/serve.mjs" --cors --no-browser --directory "${here}" --port "${port}"
