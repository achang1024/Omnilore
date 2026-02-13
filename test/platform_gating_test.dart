import 'package:flutter_test/flutter_test.dart';
import 'package:omnilore_scheduler/io/file_io_exceptions.dart';
import 'package:omnilore_scheduler/io/text_file_store_stub.dart';
import 'package:omnilore_scheduler/widgets/utils.dart';

void main() {
  test('Unsupported file store throws explicit read error', () {
    var store = UnsupportedTextFileStore();

    expect(
      () => store.readLinesSync('state.txt'),
      throwsA(isA<UnsupportedFileIoException>()),
    );
    expect(
      () => store.readLines('state.txt'),
      throwsA(isA<UnsupportedFileIoException>()),
    );
  });

  test('Unsupported file store throws explicit write error', () {
    var store = UnsupportedTextFileStore();

    expect(
      () => store.writeStringSync('state.txt', 'abc'),
      throwsA(isA<UnsupportedFileIoException>()),
    );
  });

  test('Utils formats unsupported file I/O errors for UI', () {
    var message = Utils.getErrorMessage(
      UnsupportedFileIoException('writing files'),
    );

    expect(message, contains('Local file access is not supported'));
    expect(message, contains('writing files'));
  });
}
