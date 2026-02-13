#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

fail=0

check_disallowed_import() {
  local pattern="$1"
  local description="$2"
  local allowlist="$3"

  local hits
  hits="$(grep -RIn --include='*.dart' "$pattern" lib || true)"
  if [[ -z "$hits" ]]; then
    return
  fi

  local disallowed
  disallowed="$(echo "$hits" | grep -Ev "$allowlist" || true)"
  if [[ -z "$disallowed" ]]; then
    return
  fi

  echo "Disallowed $description found outside allowlist:"
  echo "$disallowed"
  fail=1
}

check_disallowed_import \
  "import 'dart:io';" \
  "dart:io import" \
  "^lib/platform_gate.dart:|^lib/io/text_file_store_io.dart:"

check_disallowed_import \
  "import 'package:desktop_window/desktop_window.dart';" \
  "desktop_window import" \
  "^lib/window_sizing/window_sizing_desktop.dart:"

if [[ "$fail" -ne 0 ]]; then
  exit 1
fi

echo "Platform gating import checks passed."
