import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:omnilore_scheduler/scheduling.dart';

/// This file tests functionalities regarding loading courses.
void main() {
  test('Export: empty', () {
    var scheduling = Scheduling();
    scheduling.exportState('state.txt');
    var actual = File('state.txt').readAsStringSync();
    var expected =
        File('test/resources/gold/empty_state.txt').readAsStringSync();
    expect(actual, expected);
    File('state.txt').deleteSync();
  });

  test('exportStateToString: empty', () {
    var scheduling = Scheduling();
    var actual = scheduling.exportStateToString();
    var expected =
        File('test/resources/gold/empty_state.txt').readAsStringSync();
    expect(actual, expected);
  });

  test('exportStateToString: round-trip with state.txt', () async {
    var scheduling = Scheduling();
    await scheduling.loadCourses('test/resources/course.txt');
    await scheduling.loadPeople('test/resources/people.txt');

    var stateBytes = File('test/resources/state.txt').readAsBytesSync();
    scheduling.loadStateFromBytes(stateBytes);

    var exported = scheduling.exportStateToString();

    var scheduling2 = Scheduling();
    await scheduling2.loadCourses('test/resources/course.txt');
    await scheduling2.loadPeople('test/resources/people.txt');
    scheduling2.loadStateFromBytes(exported.codeUnits);

    // Verify the state matches by checking each component
    // rather than exact string (drop order is non-deterministic)
    expect(scheduling2.courseControl.getGlobalMinClassSize(),
        scheduling.courseControl.getGlobalMinClassSize());
    expect(scheduling2.courseControl.getGlobalMaxClassSize(),
        scheduling.courseControl.getGlobalMaxClassSize());
    expect(scheduling2.courseControl.getDropped().toSet(),
        scheduling.courseControl.getDropped().toSet());
    expect(scheduling2.courseControl.getGo().toSet(),
        scheduling.courseControl.getGo().toSet());
  });

  test('exportState still writes to file (desktop compat)', () {
    var scheduling = Scheduling();
    scheduling.exportState('test_output_state.txt');
    var actual = File('test_output_state.txt').readAsStringSync();
    var expected =
        File('test/resources/gold/empty_state.txt').readAsStringSync();
    expect(actual, expected);
    File('test_output_state.txt').deleteSync();
  });
}