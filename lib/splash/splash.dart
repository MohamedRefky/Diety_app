import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:diety/Asks/Gender.dart';
import 'package:diety/Core/Colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class animated_splash_screen extends StatelessWidget {
  const animated_splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 200,
        backgroundColor: AppColors.background,
        pageTransitionType: PageTransitionType.leftToRight,
        splashTransition: SplashTransition.rotationTransition,
        splash: const CircleAvatar(
          radius: 75,
          backgroundImage: AssetImage('Images/logo.jpg'),
        ),
        nextScreen: const Gender(),
        duration: 5000,
        animationDuration: const Duration(seconds: 5));
  }
}
