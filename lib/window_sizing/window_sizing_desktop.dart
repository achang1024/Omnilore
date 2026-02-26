import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:omnilore_scheduler/platform/desktop_platform.dart';

Future<void> setAppMinWindowSize() async {
  if (!isDesktopPlatform) return;
  await DesktopWindow.setMinWindowSize(const Size(1400, 500));
}
