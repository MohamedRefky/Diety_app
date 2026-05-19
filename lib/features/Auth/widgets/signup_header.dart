import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sign Up',
      style: TextStyle(
        fontSize: 40,
        color: AppColors.text,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
