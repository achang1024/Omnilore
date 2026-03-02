import 'package:omnilore_scheduler/io/autosave_store_stub.dart'
    if (dart.library.html) 'package:omnilore_scheduler/io/autosave_store_web.dart'
    as impl;

void saveAutosave(String content) => impl.saveAutosave(content);

String? loadAutosave() => impl.loadAutosave();

void clearAutosave() => impl.clearAutosave();

void saveHardSave(String content) => impl.saveHardSave(content);

String? loadHardSave() => impl.loadHardSave();

void clearHardSave() => impl.clearHardSave();

String? getAutosaveTimestamp() => impl.getAutosaveTimestamp();

String? getHardSaveTimestamp() => impl.getHardSaveTimestamp();

void saveCourseData(String content) => impl.saveCourseData(content);

String? loadCourseData() => impl.loadCourseData();

void clearCourseData() => impl.clearCourseData();

void savePeopleData(String content) => impl.savePeopleData(content);

String? loadPeopleData() => impl.loadPeopleData();

void clearPeopleData() => impl.clearPeopleData();
