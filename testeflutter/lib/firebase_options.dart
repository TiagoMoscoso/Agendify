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
    apiKey: 'AIzaSyCYjNvVlNzfYGTRtWCcc9eLZ9jP10PnMPI',
    appId: '1:743578384186:web:849cd302f8c5bdaf188203',
    messagingSenderId: '743578384186',
    projectId: 'agendfy',
    authDomain: 'agendfy.firebaseapp.com',
    databaseURL: 'https://agendfy-default-rtdb.firebaseio.com',
    storageBucket: 'agendfy.appspot.com',
    measurementId: 'G-4ECBLQ6FC5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6Agne1kJqf3oSwx_eF-41BOm9PEJu2RM',
    appId: '1:743578384186:android:3af5beb01e893449188203',
    messagingSenderId: '743578384186',
    projectId: 'agendfy',
    databaseURL: 'https://agendfy-default-rtdb.firebaseio.com',
    storageBucket: 'agendfy.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByTZbp4MMQjCbqTsCam07EyIDJBwpwQSI',
    appId: '1:743578384186:ios:06d902b047060ffd188203',
    messagingSenderId: '743578384186',
    projectId: 'agendfy',
    databaseURL: 'https://agendfy-default-rtdb.firebaseio.com',
    storageBucket: 'agendfy.appspot.com',
    iosBundleId: 'com.example.testeflutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByTZbp4MMQjCbqTsCam07EyIDJBwpwQSI',
    appId: '1:743578384186:ios:551452d53df24f6b188203',
    messagingSenderId: '743578384186',
    projectId: 'agendfy',
    databaseURL: 'https://agendfy-default-rtdb.firebaseio.com',
    storageBucket: 'agendfy.appspot.com',
    iosBundleId: 'com.example.testeflutter.RunnerTests',
  );
}
