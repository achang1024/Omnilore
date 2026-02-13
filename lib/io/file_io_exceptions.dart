class UnsupportedFileIoException implements Exception {
  UnsupportedFileIoException(this.operation);

  final String operation;

  String get userMessage =>
      'Local file access is not supported for "$operation" on this platform.';

  @override
  String toString() => userMessage;
}
