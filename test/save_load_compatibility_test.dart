import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:omnilore_scheduler/model/state_of_processing.dart';
import 'package:omnilore_scheduler/scheduling.dart';

Future<List<String>> _driveToOutput(Scheduling scheduling) async {
  scheduling.courseControl
      .setGlobalMinMaxClassSize(0, scheduling.getNumPeople());

  final goCourses = scheduling.courseControl.getGo().toList(growable: false)
    ..sort((a, b) => a.compareTo(b));

  const totalTimeSlots = 20;
  for (var i = 0; i < goCourses.length; i++) {
    scheduling.scheduleControl.schedule(goCourses[i], i % totalTimeSlots);
  }

  expect(scheduling.getStateOfProcessing(), StateOfProcessing.coordinator);

  for (var course in goCourses) {
    final resultingClass =
        scheduling.overviewData.getPeopleForResultingClass(course);
    expect(resultingClass, isNotEmpty,
        reason: 'Course $course should have at least one participant.');
    scheduling.courseControl.setMainCoCoordinator(course, resultingClass.first);
  }

  expect(scheduling.getStateOfProcessing(), StateOfProcessing.output);
  return goCourses;
}

String _normalize(String content) {
  return content.endsWith('\n') ? content : '$content\n';
}

void main() {
  test('Bundled save payload round-trips from a fresh Scheduling instance',
      () async {
    final courseText =
        _normalize(File('test/resources/course_split.txt').readAsStringSync());
    final peopleText = _normalize(
        File('test/resources/people_schedule.txt').readAsStringSync());

    final source = Scheduling();
    await source.loadCoursesFromBytes(utf8.encode(courseText));
    await source.loadPeopleFromBytes(utf8.encode(peopleText));
    final goCourses = await _driveToOutput(source);

    final stateContent = source.exportStateToString();
    final bundled =
      'CourseFile:\n${courseText}PeopleFile:\n$peopleText$stateContent';

    final restored = Scheduling();
    await restored.loadCoursesFromBytes(utf8.encode(courseText));
    await restored.loadPeopleFromBytes(utf8.encode(peopleText));
    restored.loadStateFromBytes(utf8.encode(bundled));

    expect(restored.getNumPeople(), source.getNumPeople());
    expect(restored.getCourseCodes().length, source.getCourseCodes().length);
    expect(restored.getStateOfProcessing(), source.getStateOfProcessing());

    for (var course in goCourses) {
      expect(restored.scheduleControl.scheduledTimeFor(course),
          source.scheduleControl.scheduledTimeFor(course));
    }
  });

  test('Legacy state-only payload remains loadable with imported base data',
      () async {
    final courseText =
        _normalize(File('test/resources/course_split.txt').readAsStringSync());
    final peopleText = _normalize(
        File('test/resources/people_schedule.txt').readAsStringSync());

    final source = Scheduling();
    await source.loadCoursesFromBytes(utf8.encode(courseText));
    await source.loadPeopleFromBytes(utf8.encode(peopleText));
    final goCourses = await _driveToOutput(source);

    final legacyStateOnly = source.exportStateToString();

    final restored = Scheduling();
    await restored.loadCoursesFromBytes(utf8.encode(courseText));
    await restored.loadPeopleFromBytes(utf8.encode(peopleText));
    restored.loadStateFromBytes(utf8.encode(legacyStateOnly));

    expect(restored.getStateOfProcessing(), StateOfProcessing.output);
    for (var course in goCourses) {
      expect(restored.scheduleControl.scheduledTimeFor(course),
          source.scheduleControl.scheduledTimeFor(course));
    }
  });

  test('Path-based source text can be bundled and restored cross-instance',
      () async {
    final source = Scheduling();
    final courseText = source.readText('test/resources/course_split.txt');
    final peopleText = source.readText('test/resources/people_schedule.txt');

    expect(courseText, contains('\t'));
    expect(peopleText, contains('\t'));
    expect(courseText.endsWith('\n'), isTrue);
    expect(peopleText.endsWith('\n'), isTrue);

    await source.loadCourses('test/resources/course_split.txt');
    await source.loadPeople('test/resources/people_schedule.txt');
    await _driveToOutput(source);

    final bundled =
      'CourseFile:\n${courseText}PeopleFile:\n$peopleText${source.exportStateToString()}';

    final restored = Scheduling();
    await restored.loadCoursesFromBytes(utf8.encode(courseText));
    await restored.loadPeopleFromBytes(utf8.encode(peopleText));
    restored.loadStateFromBytes(utf8.encode(bundled));

    expect(restored.getNumPeople(), source.getNumPeople());
    expect(restored.getCourseCodes().length, source.getCourseCodes().length);
    expect(restored.getStateOfProcessing(), StateOfProcessing.output);
  });
}
