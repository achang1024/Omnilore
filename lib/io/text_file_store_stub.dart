import 'package:omnilore_scheduler/io/file_io_exceptions.dart';
import 'package:omnilore_scheduler/io/text_file_store.dart';

class UnsupportedTextFileStore implements TextFileStore {
  @override
  Stream<String> readLines(String path) =>
      throw UnsupportedFileIoException('reading files');

  @override
  List<String> readLinesSync(String path) =>
      throw UnsupportedFileIoException('reading files');

  @override
  void writeStringSync(String path, String content, {bool append = false}) =>
      throw UnsupportedFileIoException('writing files');
}

TextFileStore createTextFileStoreImpl() => UnsupportedTextFileStore();
