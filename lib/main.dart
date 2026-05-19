import 'dart:developer';

import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/services/app_initializer.dart';
import 'package:diety/Core/model/firenotifications.dart';
import 'package:diety/Core/model/notifications.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Auth/views/login_view.dart';
import 'package:diety/features/Auth/views/signup_view.dart';
import 'package:diety/features/main/MainNavBarScreen.dart';
import 'package:diety/features/Onboarding/view/onbording_screan.dart';
import 'package:diety/features/Search_Food/view/Dinner.dart';
import 'package:diety/features/Splash/Splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all application-level services
  await AppInitializer.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserInfoProvider(),
        ),
        BlocProvider(
          create: (context) => UserInfoCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _listenToAuthState();
    _listenToNotificationStream();
  }

  void _listenToAuthState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('Auth State: User is currently signed out');
      } else {
        log('Auth State: User is signed in (${user.email})');
      }
    });
  }

  void _listenToNotificationStream() {
    localnotificationservice.streamController.stream.listen((response) {
      log("Notification clicked. ID: ${response.id}, Payload: ${response.payload}");

      if (!mounted) return;

      if (response.id == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Dinner(response: response),
          ),
        );
      } else if (response.id == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainNavBarScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Diety',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: Brightness.dark, // Standardize dark mode support across the app
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const SplashView()
          : const OnboardingScreen(),
      routes: {
        "SignUp": (context) => const SignUpView(),
        "SingUp": (context) => const SignUpView(), // Keep legacy route name to prevent breakages
        "Login": (context) => const LoginView(),
        "home": (context) => const MainNavBarScreen(),
      },
    );
  }
}
