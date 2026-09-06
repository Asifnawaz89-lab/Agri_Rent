// Generated Firebase Options Placeholder
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',
    appId: '1:123456789:web:abcdef',
    messagingSenderId: '123456789',
    projectId: 'agri-rent-project',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',
    appId: '1:123456789:android:abcdef',
    messagingSenderId: '123456789',
    projectId: 'agri-rent-project',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR-API-KEY',
    appId: '1:123456789:ios:abcdef',
    messagingSenderId: '123456789',
    projectId: 'agri-rent-project',
  );
}