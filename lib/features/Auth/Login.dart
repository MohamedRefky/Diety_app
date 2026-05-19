// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/Core/widget/Custom_TextFormFealed.dart';
import 'package:diety/features/Admin/view/AdminHome.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Auth/SignUp.dart';
import 'package:diety/features/Auth/cubit/auth_cubit.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isInternetAvailable = true;
  bool isNotVisible = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _listenToConnectivity();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen((dynamic result) {
      setState(() {
        if (result is List) {
          isInternetAvailable = (!result.contains(ConnectivityResult.none));
        } else {
          isInternetAvailable = (result != ConnectivityResult.none);
        }
      });
    });
  }

  Future<bool> _checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  Future<void> _handlePostLoginNavigation(User user) async {
    if (user.email == 'mustaphamahmoud952@gmail.com') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Admin_Home()),
      );
      return;
    }

    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      
      final Widget nextScreen = _determineNextScreen(userDoc);
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    } catch (e) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Gender()),
      );
    }
  }

  Widget _determineNextScreen(DocumentSnapshot userDoc) {
    if (userDoc.exists) {
      final data = userDoc.data() as Map<String, dynamic>?;
      final String userAge = data?['age']?.toString() ?? '0';
      if (userAge == '0' || userAge.isEmpty) {
        return const Gender();
      } else {
        return const Home();
      }
    }
    return const Gender();
  }

  void _showSnackBar(String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
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
            _handlePostLoginNavigation(state.user);
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
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildHeader(),
                          const Gap(40),
                          _buildEmailField(),
                          const Gap(25),
                          _buildPasswordField(),
                          const Gap(5),
                          _buildForgotPasswordButton(context),
                          const Gap(15),
                          _buildLoginButton(context, isLoading),
                          const Gap(40),
                          _buildDivider(),
                          const Gap(20),
                          _buildSocialLoginButtons(context),
                          const Gap(20),
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
      'Login',
      style: TextStyle(
        fontSize: 40,
        color: AppColors.text,
        fontWeight: FontWeight.w600,
      ),
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
      suffixIcon: null,
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

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 10),
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () async {
          final String email = emailController.text.trim();
          if (email.isEmpty) {
            _showSnackBar("Please enter your email first");
            return;
          }
          if (!email.toLowerCase().endsWith('@gmail.com')) {
            _showSnackBar("Only @gmail.com emails are allowed");
            return;
          }

          context.read<AuthCubit>().sendPasswordResetEmail(email);
          _showSnackBar("Reset link requested if email exists", color: Colors.green);
        },
        child: Text(
          "Forget Password ?",
          style: TextStyle(fontSize: 12, color: AppColors.text),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, bool isLoading) {
    if (isLoading) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.button),
      );
    }

    return Custom_Button(
      text: 'Login',
      onPressed: () async {
        if (!await _checkInternetConnectivity()) {
          _showSnackBar("No internet connection available");
          return;
        }

        if (formKey.currentState!.validate()) {
          context.read<AuthCubit>().loginWithEmailAndPassword(
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

  Widget _buildSocialLoginButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(
          assetPath: 'assets/Images/Google.png',
          onTap: () => context.read<AuthCubit>().signInWithGoogle(),
        ),
        const Gap(10),
        _buildSocialIcon(
          assetPath: 'assets/Images/facebook.jpg',
          onTap: () => context.read<AuthCubit>().signInWithFacebook(),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({required String assetPath, required VoidCallback onTap}) {
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

  Widget _buildFooter(BuildContext context) {
    return Row(
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
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignUp()),
            );
          },
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
    );
  }
}
