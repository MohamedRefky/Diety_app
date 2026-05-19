import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Login',
      style: TextStyle(
        fontSize: 40,
        color: AppColors.text,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
