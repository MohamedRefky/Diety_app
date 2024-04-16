import 'package:diety/features/Asks/model/UserInfoProvider.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Auth/Login.dart';
import 'package:diety/features/Auth/SignUp.dart';
import 'package:diety/features/Home/Home.dart';
import 'package:diety/features/Onboarding/view/onbording_screan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAS10mEL7gbI3V5d10dHz3qWc98KR8SrgI",
          databaseURL: 'https://dietyapp-c69c7-default-rtdb.firebaseio.com/',
          appId: "1:674799164198:android:7463b52021bccf9571ffe7",
          messagingSenderId: '674799164198',
          projectId: 'DIETYAPP'));

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          UserInfoProvider(), // Create an instance of UserInfoProvider
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
        print('================================User is currently signed out!');
      } else {
        print('================================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? const Gender()
            : const OnboardingScreen(),
        routes: {
          "SingUp": (context) => const SignUp(),
          "Login": (context) => const Login(),
          "home": (context) => const Home(),
          "Gender": (context) => const Gender(),
        });
  }
}
