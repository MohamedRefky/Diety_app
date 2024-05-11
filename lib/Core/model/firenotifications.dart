import 'dart:async';
import 'dart:developer';

import 'package:diety/features/Home/view/view/Home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void handlemessage(RemoteMessage? message) {
  if (message == null) return;

  navigatorKey.currentState?.pushNamed(
    Home.route,
    arguments: message,
  );
}

Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then(handlemessage);
  FirebaseMessaging.onMessageOpenedApp.listen((handlemessage));
  FirebaseMessaging.onBackgroundMessage((handleBackgroundMessage));
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title: ${message.notification?.title}");
  log("Body: ${message.notification?.body}");
  log("Payload: ${message.data}");
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log("Token: $fCMToken");
    initPushNotifications();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
