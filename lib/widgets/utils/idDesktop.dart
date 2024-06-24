import 'dart:io';

class IsMobile {
  static get isMobile {
    if (Platform.isLinux ||
        Platform.isMacOS ||
        Platform.isWindows ||
        Platform.isFuchsia) {
          
      return true;
    } else {
      return false;
    }
  }
}
