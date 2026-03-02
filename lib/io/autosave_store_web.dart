import 'package:web/web.dart' as web;

const _autosaveKey = 'omnilore_autosave';
const _autosaveTimeKey = 'omnilore_autosave_time';
const _hardSaveKey = 'omnilore_hardsave';
const _hardSaveTimeKey = 'omnilore_hardsave_time';
const _courseDataKey = 'omnilore_course_data';
const _peopleDataKey = 'omnilore_people_data';

void saveAutosave(String content) {
  web.window.localStorage.setItem(_autosaveKey, content);
  web.window.localStorage.setItem(
      _autosaveTimeKey, DateTime.now().toIso8601String());
}

String? loadAutosave() {
  final value = web.window.localStorage.getItem(_autosaveKey);
  return (value != null && value.isNotEmpty) ? value : null;
}

void clearAutosave() {
  web.window.localStorage.removeItem(_autosaveKey);
  web.window.localStorage.removeItem(_autosaveTimeKey);
}

void saveHardSave(String content) {
  web.window.localStorage.setItem(_hardSaveKey, content);
  web.window.localStorage.setItem(
      _hardSaveTimeKey, DateTime.now().toIso8601String());
}

String? loadHardSave() {
  final value = web.window.localStorage.getItem(_hardSaveKey);
  return (value != null && value.isNotEmpty) ? value : null;
}

void clearHardSave() {
  web.window.localStorage.removeItem(_hardSaveKey);
  web.window.localStorage.removeItem(_hardSaveTimeKey);
}

String? getAutosaveTimestamp() {
  return web.window.localStorage.getItem(_autosaveTimeKey);
}

String? getHardSaveTimestamp() {
  return web.window.localStorage.getItem(_hardSaveTimeKey);
}

void saveCourseData(String content) {
  web.window.localStorage.setItem(_courseDataKey, content);
}

String? loadCourseData() {
  final value = web.window.localStorage.getItem(_courseDataKey);
  return (value != null && value.isNotEmpty) ? value : null;
}

void clearCourseData() {
  web.window.localStorage.removeItem(_courseDataKey);
}

void savePeopleData(String content) {
  web.window.localStorage.setItem(_peopleDataKey, content);
}

String? loadPeopleData() {
  final value = web.window.localStorage.getItem(_peopleDataKey);
  return (value != null && value.isNotEmpty) ? value : null;
}

void clearPeopleData() {
  web.window.localStorage.removeItem(_peopleDataKey);
}
