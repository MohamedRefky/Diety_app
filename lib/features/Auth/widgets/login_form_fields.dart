import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/Core/widget/Custom_TextFormFealed.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoginFormFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isNotVisible;
  final bool isLoading;
  final VoidCallback onToggleVisibility;
  final VoidCallback onForgotPassword;
  final VoidCallback onLogin;

  const LoginFormFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isNotVisible,
    required this.isLoading,
    required this.onToggleVisibility,
    required this.onForgotPassword,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email Field
        CusomTextFormFeald(
          mycontroller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Email';
            }
            if (!value.trim().toLowerCase().endsWith('@gmail.com')) {
              return 'Only @gmail.com emails are allowed';
            }
            return null;
          },
          prefixIcon: Icons.email,
          lable: 'Email',
          suffixIcon: null,
        ),
        const Gap(25),
        // Password Field
        CusomTextFormFeald(
          mycontroller: passwordController,
          obscureText: isNotVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Your Password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          prefixIcon: Icons.lock,
          lable: 'Password',
          suffixIcon: IconButton(
            onPressed: onToggleVisibility,
            icon: Icon(
              isNotVisible
                  ? Icons.visibility_off
                  : Icons.remove_red_eye_rounded,
            ),
            color: AppColors.text,
          ),
        ),
        const Gap(5),
        // Forgot Password Button
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 10),
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: onForgotPassword,
            child: Text(
              "Forget Password ?",
              style: TextStyle(fontSize: 12, color: AppColors.text),
            ),
          ),
        ),
        const Gap(15),
        // Login Button
        isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.button),
              )
            : Custom_Button(
                text: 'Login',
                onPressed: onLogin,
              ),
      ],
    );
  }
}
