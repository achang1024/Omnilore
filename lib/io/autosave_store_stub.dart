// No-op autosave store for desktop and test environments.

void saveAutosave(String content) {}

String? loadAutosave() => null;

void clearAutosave() {}

void saveHardSave(String content) {}

String? loadHardSave() => null;

void clearHardSave() {}

String? getAutosaveTimestamp() => null;

String? getHardSaveTimestamp() => null;
