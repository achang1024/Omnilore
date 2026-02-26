# Deliverable 2 Codebase Review (Team 34)

Date: 2026-02-05

## Scope
Initial technical groundwork for the Omnilore Scheduling Program codebase. Focused on web porting readiness and identified defects mentioned in Deliverable 1/2 planning.

## High-Level Architecture
- Flutter app with UI in `lib/widgets/*` and orchestration in `lib/widgets/screen.dart`.
- Core scheduling logic in `lib/scheduling.dart`.
- Domain models in `lib/model/*`.
- Data stores and file parsing in `lib/store/*`.
- Compute modules for scheduling logic in `lib/compute/*`.

## Web Porting Readiness (Key Findings)
- `dart:io` and filesystem access are used widely:
  - `lib/main.dart` imports `dart:io` and `desktop_window` for desktop window sizing.
  - `lib/scheduling.dart` writes outputs (rosters, mail merge, state export) and reads state via `File`.
  - `lib/store/courses.dart` and `lib/store/people.dart` load data from local file paths.
- These APIs are not supported on Flutter Web and need replacement with web-compatible file selection and download flows.

## Known Bugs Mentioned in Deliverables
### 1) “Co-Coordinator” bug (likely in coordinator assignment logic)
- `CourseControl.setMainCoCoordinator()` does not update the main coordinator slot when a coordinator already exists. Instead it writes to the secondary slot if the name differs.
  - This likely prevents changing the main coordinator once set, and can mis-assign intended main/CC roles.
  - File: `lib/compute/course_control.dart`.

### 2) “Show Splits” bug
- The “Show Splits” button is currently disabled (`onPressed: null`).
  - File: `lib/widgets/names_display_mode.dart`.
  - There is no handler wired in `lib/widgets/screen.dart` for displaying split results without implementing them.

## Technical & Maintenance Concerns
- Strong coupling between UI and scheduling logic (state transitions and UI updates are interleaved in `screen.dart`).
- File-based I/O is synchronous in some output paths (e.g., `writeAsStringSync`), which is incompatible with web and may block UI on desktop.
- Scheduling logic assumes local file path inputs for data ingestion; web requires user-provided files or remote storage.
- Coordinator state and split state are stored in memory without persistence; export/import state uses files only.

## Proposed Web Conversion Approach (High-Level)
1) Replace direct filesystem access with web-safe abstractions.
   - Input: file picker (web) -> parse from bytes/string.
   - Output: generate files in-memory and trigger browser download.
2) Gate desktop-only APIs:
   - `DesktopWindow` usage should be conditional on non-web and factored behind platform guards.
3) Introduce a storage abstraction for intermediate state (local storage or downloadable state file).
4) Convert any synchronous I/O to async and ensure UI uses async flows.

## Task List (Initial)
Porting-first tasks (highest priority):
- Replace `dart:io` I/O in `Courses`, `People`, and `Scheduling` with web-safe file import/export utilities.
- Add web download/export functionality for roster outputs and intermediate state.
- Make `main.dart` desktop window sizing conditional or no-op on web.

Bug fix tasks (after porting):
- Fix coordinator assignment logic in `CourseControl.setMainCoCoordinator()`.
- Implement “Show Splits” UI: display split preview without committing changes.

## Suggested Ownership (for planning)
- Web I/O abstraction: 1-2 devs.
- Output/export for roster/state: 1 dev.
- Coordinator bug fix: 1 dev.
- Show Splits implementation: 1 dev.

## Notes
Deliverable 2 explicitly prioritizes web porting first and bug fixes after. The task list reflects that ordering.
