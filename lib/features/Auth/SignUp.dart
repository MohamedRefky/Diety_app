// ignore_for_file: use_build_context_synchronously

import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/Core/widget/Custom_TextFormFealed.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Auth/Login.dart';
import 'package:diety/features/Auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isNotVisible = true;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showSnackBar("Account created successfully! Welcome!", color: Colors.green);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Gender()),
              (route) => false,
            );
          } else if (state is AuthFailure) {
            _showSnackBar(state.errorMessage);
          }
        },
        builder: (context, state) {
          final bool isLoading = state is AuthLoading;

          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Gap(20),
                          _buildHeader(),
                          const Gap(30),
                          _buildNameFields(),
                          const Gap(15),
                          _buildEmailField(),
                          const Gap(15),
                          _buildPasswordField(),
                          const Gap(15),
                          _buildConfirmPasswordField(),
                          const Gap(20),
                          _buildSignUpButton(context, isLoading),
                          const Gap(20),
                          _buildDivider(),
                          const Gap(15),
                          _buildFooter(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      'Sign Up',
      style: TextStyle(
        fontSize: 40,
        color: AppColors.text,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildNameFields() {
    return Row(
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
    );
  }

  Widget _buildEmailField() {
    return CusomTextFormFeald(
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
    );
  }

  Widget _buildPasswordField() {
    return CusomTextFormFeald(
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
        onPressed: () {
          setState(() {
            isNotVisible = !isNotVisible;
          });
        },
        icon: Icon(
          isNotVisible ? Icons.visibility_off : Icons.remove_red_eye_rounded,
        ),
        color: AppColors.text,
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return CusomTextFormFeald(
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
    );
  }

  Widget _buildSignUpButton(BuildContext context, bool isLoading) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }

    return Custom_Button(
      text: 'Sign Up',
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (passwordController.text != confirmPasswordController.text) {
            _showSnackBar("Passwords do not match");
            return;
          }

          context.read<AuthCubit>().signUpWithEmailAndPassword(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                password: passwordController.text,
              );
        }
      },
    );
  }

  Widget _buildDivider() {
    return Row(
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
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
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
    );
  }
}
