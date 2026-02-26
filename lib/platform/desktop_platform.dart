import 'desktop_platform_stub.dart'
    if (dart.library.io) 'desktop_platform_io.dart' as impl;

bool get isDesktopPlatform => impl.isDesktopPlatform;
