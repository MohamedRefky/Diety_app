import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAS10mEL7gbI3V5d10dHz3qWc98KR8SrgI',
    appId: '1:674799164198:android:7463b52021bccf9571ffe7',
    messagingSenderId: '674799164198',
    projectId: 'dietyapp-c69c7',
    databaseURL: 'https://dietyapp-c69c7-default-rtdb.firebaseio.com/',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAS10mEL7gbI3V5d10dHz3qWc98KR8SrgI',
    appId: '1:674799164198:ios:7463b52021bccf9571ffe7',
    messagingSenderId: '674799164198',
    projectId: 'dietyapp-c69c7',
    databaseURL: 'https://dietyapp-c69c7-default-rtdb.firebaseio.com/',
  );
}
