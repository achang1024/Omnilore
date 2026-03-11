import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:omnilore_scheduler/model/state_of_processing.dart';
import 'package:omnilore_scheduler/scheduling.dart';

void main() {
  test('Byte-based import matches file-based import behavior', () async {
    var scheduling = Scheduling();

    var courseBytes = File('test/resources/course.txt').readAsBytesSync();
    var peopleBytes = File('test/resources/people.txt').readAsBytesSync();

    expect(await scheduling.loadCoursesFromBytes(courseBytes), 24);
    expect(await scheduling.loadPeopleFromBytes(peopleBytes), 267);

    expect(scheduling.getNumPeople(), 267);
    expect(scheduling.getCourseCodes().length, 24);
    expect(scheduling.getStateOfProcessing(), StateOfProcessing.drop);
  });

  test('Full scheduling pipeline reaches output and produces exports', () async {
    var scheduling = Scheduling();
    await scheduling.loadCourses('test/resources/course_split.txt');
    await scheduling.loadPeople('test/resources/people_schedule.txt');

    // Normalize size constraints so this integration test remains focused on
    // scheduling/coordinator/export behavior rather than fixture-specific
    // drop/split thresholds.
    scheduling.courseControl
      .setGlobalMinMaxClassSize(0, scheduling.getNumPeople());

    expect(scheduling.getStateOfProcessing(), StateOfProcessing.schedule);

    var goCourses = scheduling.courseControl.getGo().toList(growable: false)
      ..sort((a, b) => a.compareTo(b));

    // The scheduler supports 20 time slots with up to N classrooms per slot.
    // Validate fixture size against actual scheduling capacity.
    const totalTimeSlots = 20;
    final capacity =
      totalTimeSlots * scheduling.scheduleControl.getNbrClassrooms();
    expect(goCourses.length, lessThanOrEqualTo(capacity),
      reason:
        'Expected test fixture to fit in $capacity available schedule positions.');

    for (var i = 0; i < goCourses.length; i++) {
      scheduling.scheduleControl.schedule(goCourses[i], i % totalTimeSlots);
    }

    expect(scheduling.getStateOfProcessing(), StateOfProcessing.coordinator);

    for (var course in goCourses) {
      var resultingClass = scheduling.overviewData.getPeopleForResultingClass(course);
      expect(resultingClass, isNotEmpty,
          reason: 'Course $course should have at least one participant.');
      scheduling.courseControl.setMainCoCoordinator(course, resultingClass.first);
    }

    expect(scheduling.getStateOfProcessing(), StateOfProcessing.output);

    var rosterWithCc = scheduling.outputRosterCCToString();
    var rosterWithPhone = scheduling.outputRosterPhoneToString();
    var mailMerge = scheduling.outputMMToString();

    expect(rosterWithCc, contains('(C)'));
    expect(rosterWithCc, contains('Mon'));
    expect(rosterWithPhone, contains('Mon'));
    expect(mailMerge.trim().split('\n').length, scheduling.getNumPeople());
  });
}
