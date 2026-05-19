import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';

class SignupFooter extends StatelessWidget {
  final VoidCallback onLoginNavigate;

  const SignupFooter({
    super.key,
    required this.onLoginNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider
        Row(
          children: <Widget>[
            Expanded(child: Divider(color: AppColors.text)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'or',
                style: TextStyle(color: AppColors.text, fontSize: 18),
              ),
            ),
            Expanded(child: Divider(color: AppColors.text)),
          ],
        ),
        // Navigate to Login Screen
        Row(
          children: [
            Text(
              'Already I have account',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: onLoginNavigate,
              child: Text(
                'Login',
                style: TextStyle(
                  color: AppColors.button,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
