import 'dart:convert';
import 'dart:io';

Stream<String> openReadUtf8Lines(String path) {
  return File(path)
      .openRead()
      .transform(utf8.decoder)
      .transform(const LineSplitter());
}

List<String> readUtf8LinesSync(String path) {
  return File(path).readAsLinesSync();
}

void writeTextFileSync(String path, String content) {
  File(path).writeAsStringSync(content);
}
