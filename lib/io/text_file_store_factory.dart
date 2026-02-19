import 'package:omnilore_scheduler/io/text_file_store.dart';
import 'package:omnilore_scheduler/io/text_file_store_stub.dart'
    if (dart.library.io) 'package:omnilore_scheduler/io/text_file_store_io.dart'
    as impl;

export 'package:omnilore_scheduler/io/web_download_stub.dart'
    if (dart.library.html) 'package:omnilore_scheduler/io/web_download_web.dart';

TextFileStore createTextFileStore() => impl.createTextFileStoreImpl();