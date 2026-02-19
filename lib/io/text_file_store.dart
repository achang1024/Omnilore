abstract class TextFileStore {
  Stream<String> readLines(String path);

  List<String> readLinesSync(String path);

  void writeStringSync(String path, String content, {bool append = false});
}
