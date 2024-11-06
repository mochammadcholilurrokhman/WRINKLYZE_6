// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyAHJaZgiJJ7mMsf3ucEO1A2kX1QWS6AKDo',
    appId: '1:1050006956718:web:9df39541485afacf62db3f',
    messagingSenderId: '1050006956718',
    projectId: 'mobile-app-wrinklyze',
    authDomain: 'mobile-app-wrinklyze.firebaseapp.com',
    storageBucket: 'mobile-app-wrinklyze.firebasestorage.app',
    measurementId: 'G-H8VBNJD96V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAH_7qRD7BBpKqdAB0V0Bl0OcJ53LuS8Ko',
    appId: '1:1050006956718:android:84edf1ba9d2e277b62db3f',
    messagingSenderId: '1050006956718',
    projectId: 'mobile-app-wrinklyze',
    storageBucket: 'mobile-app-wrinklyze.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_fM6tGurx9dd3FoImwWEM0hoHZKAADyY',
    appId: '1:1050006956718:ios:7685f3058beca77162db3f',
    messagingSenderId: '1050006956718',
    projectId: 'mobile-app-wrinklyze',
    storageBucket: 'mobile-app-wrinklyze.firebasestorage.app',
    iosBundleId: 'com.example.wrinklyze6',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_fM6tGurx9dd3FoImwWEM0hoHZKAADyY',
    appId: '1:1050006956718:ios:7685f3058beca77162db3f',
    messagingSenderId: '1050006956718',
    projectId: 'mobile-app-wrinklyze',
    storageBucket: 'mobile-app-wrinklyze.firebasestorage.app',
    iosBundleId: 'com.example.wrinklyze6',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHJaZgiJJ7mMsf3ucEO1A2kX1QWS6AKDo',
    appId: '1:1050006956718:web:6d164159c561b46262db3f',
    messagingSenderId: '1050006956718',
    projectId: 'mobile-app-wrinklyze',
    authDomain: 'mobile-app-wrinklyze.firebaseapp.com',
    storageBucket: 'mobile-app-wrinklyze.firebasestorage.app',
    measurementId: 'G-CNBLN8028C',
  );

}