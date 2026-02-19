import 'dart:convert';
import 'dart:io';

import 'package:omnilore_scheduler/io/text_file_store.dart';

class IoTextFileStore implements TextFileStore {
  @override
  Stream<String> readLines(String path) {
    return File(path)
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter());
  }

  @override
  List<String> readLinesSync(String path) {
    return File(path).readAsLinesSync();
  }

  @override
  void writeStringSync(String path, String content, {bool append = false}) {
    File(path).writeAsStringSync(
      content,
      mode: append ? FileMode.append : FileMode.write,
    );
  }
}

TextFileStore createTextFileStoreImpl() => IoTextFileStore();
