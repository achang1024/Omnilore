# Platform Gating Rules

## Purpose
This project supports desktop and non-desktop targets. Desktop-only APIs must be
isolated so non-desktop builds remain safe.

## Rules
1. Never import `package:desktop_window/desktop_window.dart` outside:
   - `lib/window_sizing/window_sizing_desktop.dart`
2. Never import `dart:io` outside:
   - `lib/platform_gate.dart`
   - `lib/io/text_file_store_io.dart`
3. Keep shared app entry code platform-safe:
   - `lib/main.dart` must call facades, not desktop APIs directly.
4. Keep core logic platform-safe:
   - `lib/scheduling.dart`, `lib/store/`, and `lib/compute/` should use
     abstractions (`TextFileStore`) rather than direct file APIs.
5. For unsupported platforms, throw explicit typed exceptions and surface clear
   UI messages.

## Current Facades
- Window sizing facade:
  - `lib/window_sizing/window_sizing.dart`
- File I/O facade:
  - `lib/io/text_file_store.dart`
  - `lib/io/text_file_store_factory.dart`

## PR Checklist
- Desktop-only imports remain in approved files only.
- New platform-sensitive behavior uses conditional imports or injected adapters.
- `./scripts/check_platform_gating.sh` passes.
- `flutter analyze` and `flutter test` pass.
