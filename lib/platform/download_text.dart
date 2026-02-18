import 'download_text_stub.dart'
    if (dart.library.html) 'download_text_web.dart' as impl;

void downloadTextFile(String fileName, String content) {
  impl.downloadTextFile(fileName, content);
}
