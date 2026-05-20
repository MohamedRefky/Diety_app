import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/services/firenotifications.dart';
import 'package:diety/Core/services/app_initializer.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Auth/views/login_view.dart';
import 'package:diety/features/Auth/views/signup_view.dart';
import 'package:diety/features/main/MainNavBarScreen.dart';
import 'package:diety/features/Onboarding/view/onbording_screan.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Diety',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness:
            Brightness.dark, // Standardize dark mode support across the app
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null
          ? const SplashView()
          : const OnboardingScreen(),
      routes: {
        "SignUp": (context) => const SignUpView(),
        "SingUp": (context) =>
            const SignUpView(), // Keep legacy route name to prevent breakages
        "Login": (context) => const LoginView(),
        "home": (context) => const MainNavBarScreen(),
      },
    );
  }
}
