import 'window_sizing_noop.dart'
    if (dart.library.io) 'window_sizing_desktop.dart' as impl;

Future<void> setAppMinWindowSize() => impl.setAppMinWindowSize();
