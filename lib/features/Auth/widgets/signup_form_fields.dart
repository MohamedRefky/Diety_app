import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/Core/widget/Custom_TextFormFealed.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignupFormFields extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isNotVisible;
  final bool isLoading;
  final VoidCallback onToggleVisibility;
  final VoidCallback onSignUp;

  const SignupFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isNotVisible,
    required this.isLoading,
    required this.onToggleVisibility,
    required this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First and Last Name Fields
        Row(
          children: [
            Expanded(
              child: CusomTextFormFeald(
                mycontroller: firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter First Name';
                  }
                  return null;
                },
                prefixIcon: Icons.person,
                lable: 'First Name',
              ),
            ),
            const Gap(10),
            Expanded(
              child: CusomTextFormFeald(
                mycontroller: lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Last Name';
                  }
                  return null;
                },
                prefixIcon: Icons.person,
                lable: 'Last Name',
              ),
            ),
          ],
        ),
        const Gap(15),
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
        ),
        const Gap(15),
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
        const Gap(15),
        // Confirm Password Field
        CusomTextFormFeald(
          mycontroller: confirmPasswordController,
          obscureText: isNotVisible,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Confirm Your Password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          prefixIcon: Icons.lock,
          lable: 'Confirm Password',
        ),
        const Gap(20),
        // Sign Up Button
        isLoading
            ? const CircularProgressIndicator()
            : Custom_Button(
                text: 'Sign Up',
                onPressed: onSignUp,
              ),
      ],
    );
  }
}
