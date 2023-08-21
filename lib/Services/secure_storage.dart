



// /es uan clse que devuele los valroes d secure storage

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // creter function que retorna  el storage

 static FlutterSecureStorage  storage() {
    final storage = FlutterSecureStorage();
    return storage;
  }
}

