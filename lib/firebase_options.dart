// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdQkdiaVeFZAiIaSHUciVbYEw4F15BoEM',
    appId: '1:599294443592:web:ff71b8bb1988f89f78d87d',
    messagingSenderId: '599294443592',
    projectId: 'prepaprofesores-e94c7',
    authDomain: 'prepaprofesores-e94c7.firebaseapp.com',
    storageBucket: 'prepaprofesores-e94c7.appspot.com',
    measurementId: 'G-EXCX1BL1EC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3BIcu7to2e6EElxazfvstmj-NKeg2Ptk',
    appId: '1:599294443592:android:9452a40896cc2d2578d87d',
    messagingSenderId: '599294443592',
    projectId: 'prepaprofesores-e94c7',
    storageBucket: 'prepaprofesores-e94c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDm5N3piDnwjAE95G8BV3c8BHr2Adr6WT0',
    appId: '1:599294443592:ios:087fdd19f1d5b3b578d87d',
    messagingSenderId: '599294443592',
    projectId: 'prepaprofesores-e94c7',
    storageBucket: 'prepaprofesores-e94c7.appspot.com',
    iosClientId: '599294443592-qhsusgi37ps225119goq6lrkcji8og2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.preppaProfesores',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDm5N3piDnwjAE95G8BV3c8BHr2Adr6WT0',
    appId: '1:599294443592:ios:087fdd19f1d5b3b578d87d',
    messagingSenderId: '599294443592',
    projectId: 'prepaprofesores-e94c7',
    storageBucket: 'prepaprofesores-e94c7.appspot.com',
    iosClientId: '599294443592-qhsusgi37ps225119goq6lrkcji8og2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.preppaProfesores',
  );
}
