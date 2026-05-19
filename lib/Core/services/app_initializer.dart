import 'dart:developer';

import 'package:diety/Core/services/firenotifications.dart';
import 'package:diety/Core/services/notifications.dart';
import 'package:diety/Core/services/workmanagerservice.dart';
import 'package:diety/features/profile/view/gemini.dart';
import 'package:diety/Core/services/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AppInitializer {
  /// Entry point to initialize all application-level services before launching the app UI.
  static Future<void> init() async {
    // 1. Initialize Firebase Core
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      log("AppInitializer: Firebase successfully initialized.");
      
      // Listen and log user authentication lifecycle changes
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log('AppInitializer [Auth]: User is currently signed out');
        } else {
          log('AppInitializer [Auth]: User is signed in (${user.email})');
        }
      });
    } catch (e) {
      if (!e.toString().contains('duplicate-app')) {
        rethrow;
      }
    }

    // 2. Initialize Gemini AI service
    Gemini.init(apiKey: GEMINI_API_KEY);
    log("AppInitializer: Gemini AI coach service initialized.");

    // 3. Initialize local notification channel configs
    await localnotificationservice.init();
    log("AppInitializer: Local notifications initialized.");

    // 4. Initialize background workers and push notifications parallelly
    await Future.wait([
      WorkManagerSercice().repetedwater(),
      FirebaseApi().initNotifications(),
    ]);
    log("AppInitializer: Background tasks and Firebase push messaging active.");
  }
}
