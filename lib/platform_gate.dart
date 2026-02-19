import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformGate {
  static bool get isDesktop =>
      !kIsWeb && (Platform.isMacOS || Platform.isLinux || Platform.isWindows);
}
