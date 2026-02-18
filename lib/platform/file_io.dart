import 'file_io_stub.dart' if (dart.library.io) 'file_io_io.dart' as impl;

Stream<String> openReadUtf8Lines(String path) {
  return impl.openReadUtf8Lines(path);
}

List<String> readUtf8LinesSync(String path) {
  return impl.readUtf8LinesSync(path);
}

void writeTextFileSync(String path, String content) {
  impl.writeTextFileSync(path, content);
}
