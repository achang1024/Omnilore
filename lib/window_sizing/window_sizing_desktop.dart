import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:omnilore_scheduler/platform_gate.dart';

Future<void> setAppMinWindowSize() async {
  if (!PlatformGate.isDesktop) return;
  await DesktopWindow.setMinWindowSize(const Size(1400, 500));
}
