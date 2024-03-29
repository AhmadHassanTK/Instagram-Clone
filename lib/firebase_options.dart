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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDdfGGL_3p4SkgsHbTNT8n0ICSUZ8bw3UA',
    appId: '1:1067303508029:web:3abb56b64afe2c6e06b254',
    messagingSenderId: '1067303508029',
    projectId: 'my-instagram-clone-2023',
    authDomain: 'my-instagram-clone-2023.firebaseapp.com',
    storageBucket: 'my-instagram-clone-2023.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVxzjPCYJYnPsPUcNPUP-sT28Ruox9JaE',
    appId: '1:1067303508029:android:0e0f0ca867ee691f06b254',
    messagingSenderId: '1067303508029',
    projectId: 'my-instagram-clone-2023',
    storageBucket: 'my-instagram-clone-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDw6RAOCYEHD47VxUt-yM5auvtAEDMWbrk',
    appId: '1:1067303508029:ios:80629b575bcbe1ea06b254',
    messagingSenderId: '1067303508029',
    projectId: 'my-instagram-clone-2023',
    storageBucket: 'my-instagram-clone-2023.appspot.com',
    iosBundleId: 'com.example.instagram',
  );
}
