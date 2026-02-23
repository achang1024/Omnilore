import 'package:omnilore_scheduler/io/text_file_store.dart';
import 'package:omnilore_scheduler/io/text_file_store_stub.dart'
    if (dart.library.io) 'package:omnilore_scheduler/io/text_file_store_io.dart'
    as impl;

TextFileStore createTextFileStore() => impl.createTextFileStoreImpl();
