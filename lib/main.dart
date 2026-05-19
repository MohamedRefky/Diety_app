import 'dart:developer';
import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/model/firenotifications.dart';
import 'package:diety/Core/model/notifications.dart';
import 'package:diety/Core/model/workmanagerservice.dart';
import 'package:diety/features/Auth/views/login_view.dart';
import 'package:diety/features/Auth/views/signup_view.dart';
import 'package:diety/features/Home/view/view/MainNavBarScreen.dart';
import 'package:diety/features/Onboarding/view/onbording_screan.dart';
import 'package:diety/features/Search_Food/view/Dinner.dart';
import 'package:diety/features/Splash/Splash.dart';
import 'package:diety/features/profile/view/gemini.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAS10mEL7gbI3V5d10dHz3qWc98KR8SrgI",
            databaseURL: 'https://dietyapp-c69c7-default-rtdb.firebaseio.com/',
            appId: "1:674799164198:android:7463b52021bccf9571ffe7",
            messagingSenderId: '674799164198',
            projectId: 'dietyapp-c69c7'));
  } catch (e) {
    if (!e.toString().contains('duplicate-app')) {
      rethrow;
    }
  }

  Gemini.init(apiKey: GEMINI_API_KEY);

  await localnotificationservice.init();
  log("localnotificationservice init");

  await Future.wait([
    //WorkManagerSercice().breakfast(),
    //WorkManagerSercice().init(),
    //WorkManagerSercice().dinner(),
    WorkManagerSercice().repetedwater(),
    //WorkManagerSercice().lunch(),
    //localnotificationservice.init(),
    FirebaseApi().initNotifications(),
  ]);

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
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        log('================================User is currently signed out!');
      } else {
        log('================================User is signed in!');
      }
    });
    super.initState();
    listenToNotificationStream();
  }

  void listenToNotificationStream() {
    localnotificationservice.streamController.stream
        .listen((NotificationResponse) {
      log(NotificationResponse.id!.toString());
      log(NotificationResponse.payload!.toString());
      if (mounted) {
        if (NotificationResponse.id == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Dinner(
                        response: NotificationResponse,
                      )));
        } else if (NotificationResponse.id == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainNavBarScreen()));
        } else {}
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
        ),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
             ? const SplashView()
             : const OnboardingScreen(),
        routes: {
          "SingUp": (context) => const SignUpView(),
          "Login": (context) => const LoginView(),
          "home": (context) => const MainNavBarScreen(),
        });
  }
}
