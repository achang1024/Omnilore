import 'package:omnilore_scheduler/io/web_download_stub.dart'
    if (dart.library.html) 'package:omnilore_scheduler/io/web_download_web.dart'
    as impl;

void triggerDownload(String content, String filename) =>
    impl.triggerDownload(content, filename);

Future<void> triggerSaveAs(String content, String suggestedName) =>
    impl.triggerSaveAs(content, suggestedName);