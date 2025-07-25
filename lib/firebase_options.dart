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
    apiKey: 'AIzaSyBUQMxSzQH0NPgKbCgCkfFo20uZVPM6E8Y',
    appId: '1:311139845600:web:a347ad6c91513489fad785',
    messagingSenderId: '311139845600',
    projectId: 'cardioguard-9cace',
    authDomain: 'cardioguard-9cace.firebaseapp.com',
    storageBucket: 'cardioguard-9cace.firebasestorage.app',
    measurementId: 'G-QG38VW60FY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcRDVU3rzkIxCVJjgv0FrYq9HFySa_BM0',
    appId: '1:311139845600:android:5d3bde22ea6b19fefad785',
    messagingSenderId: '311139845600',
    projectId: 'cardioguard-9cace',
    storageBucket: 'cardioguard-9cace.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpNwOurIxDpNxxcEqpKTu4JrxP3Y8Ic5A',
    appId: '1:311139845600:ios:7d970743cbd6c288fad785',
    messagingSenderId: '311139845600',
    projectId: 'cardioguard-9cace',
    storageBucket: 'cardioguard-9cace.firebasestorage.app',
    iosBundleId: 'com.example.cardioguard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDpNwOurIxDpNxxcEqpKTu4JrxP3Y8Ic5A',
    appId: '1:311139845600:ios:7d970743cbd6c288fad785',
    messagingSenderId: '311139845600',
    projectId: 'cardioguard-9cace',
    storageBucket: 'cardioguard-9cace.firebasestorage.app',
    iosBundleId: 'com.example.cardioguard',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBUQMxSzQH0NPgKbCgCkfFo20uZVPM6E8Y',
    appId: '1:311139845600:web:a347ad6c91513489fad785',
    messagingSenderId: '311139845600',
    projectId: 'cardioguard-9cace',
    authDomain: 'cardioguard-9cace.firebaseapp.com',
    storageBucket: 'cardioguard-9cace.firebasestorage.app',
    measurementId: 'G-QG38VW60FY',
  );

}