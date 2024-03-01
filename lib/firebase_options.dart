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
    apiKey: 'AIzaSyD0MawTelokQQqni1Bp6wi3kFgAAzXghhA',
    appId: '1:1622266947:web:90865bfd2e8759d67070f6',
    messagingSenderId: '1622266947',
    projectId: 'to-do-69057',
    authDomain: 'to-do-69057.firebaseapp.com',
    storageBucket: 'to-do-69057.appspot.com',
    measurementId: 'G-M72X5X45N3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBJ52CU57FKYyrteniuR95e_BCtsxzX_w',
    appId: '1:1622266947:android:1c28ef3ab58a02ff7070f6',
    messagingSenderId: '1622266947',
    projectId: 'to-do-69057',
    storageBucket: 'to-do-69057.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBnI0sclg-fwbP4flEH1i0KfgueHZllZ84',
    appId: '1:1622266947:ios:6ef8598618fcf2277070f6',
    messagingSenderId: '1622266947',
    projectId: 'to-do-69057',
    storageBucket: 'to-do-69057.appspot.com',
    iosBundleId: 'com.example.toDo',
  );
}