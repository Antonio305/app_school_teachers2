import 'dart:io';

class IsMobile {
  static bool isMobile() {
    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }
}
