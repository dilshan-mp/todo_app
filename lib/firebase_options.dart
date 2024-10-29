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
    apiKey: 'AIzaSyA-mFlGzGJbbEirvQkENvVQva1MI1AOI7I',
    appId: '1:968963551245:web:3cd577a8f0b780f691a544',
    messagingSenderId: '968963551245',
    projectId: 'todo-cc316',
    authDomain: 'todo-cc316.firebaseapp.com',
    storageBucket: 'todo-cc316.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCr6crW3nFkHrJeVjAc3EKqW6xEim3XPkY',
    appId: '1:968963551245:android:02c5dc082390a6fb91a544',
    messagingSenderId: '968963551245',
    projectId: 'todo-cc316',
    storageBucket: 'todo-cc316.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA27uo9RVnMZtlohDj-wBtEdyXLsjh743o',
    appId: '1:968963551245:ios:61d4045bb10d538391a544',
    messagingSenderId: '968963551245',
    projectId: 'todo-cc316',
    storageBucket: 'todo-cc316.appspot.com',
    iosClientId: '968963551245-gmfceeni59v43rkillkh5t3aihcpnrhq.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA27uo9RVnMZtlohDj-wBtEdyXLsjh743o',
    appId: '1:968963551245:ios:61d4045bb10d538391a544',
    messagingSenderId: '968963551245',
    projectId: 'todo-cc316',
    storageBucket: 'todo-cc316.appspot.com',
    iosClientId: '968963551245-gmfceeni59v43rkillkh5t3aihcpnrhq.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-mFlGzGJbbEirvQkENvVQva1MI1AOI7I',
    appId: '1:968963551245:web:f14fe496c2f29cff91a544',
    messagingSenderId: '968963551245',
    projectId: 'todo-cc316',
    authDomain: 'todo-cc316.firebaseapp.com',
    storageBucket: 'todo-cc316.appspot.com',
  );
}