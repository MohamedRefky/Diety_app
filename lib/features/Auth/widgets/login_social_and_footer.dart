import 'package:diety/Core/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginSocialAndFooter extends StatelessWidget {
  final VoidCallback onGoogleSignIn;
  final VoidCallback onFacebookSignIn;
  final VoidCallback onSignUpNavigate;

  const LoginSocialAndFooter({
    super.key,
    required this.onGoogleSignIn,
    required this.onFacebookSignIn,
    required this.onSignUpNavigate,
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
        const Gap(20),
        // Social Login Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialIcon(
              assetPath: 'assets/Images/Google.png',
              onTap: onGoogleSignIn,
            ),
            const Gap(10),
            _buildSocialIcon(
              assetPath: 'assets/Images/facebook.jpg',
              onTap: onFacebookSignIn,
            ),
          ],
        ),
        const Gap(20),
        // Footer
        Row(
          children: [
            Text(
              'If you don\'t have account.',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              onPressed: onSignUpNavigate,
              child: Text(
                'Create one !',
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

  Widget _buildSocialIcon(
      {required String assetPath, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: AppColors.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: AssetImage(assetPath),
          ),
        ),
      ),
    );
  }
}
