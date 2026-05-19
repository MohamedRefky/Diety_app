// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diety/Core/utils/snack_bar.dart';
import 'package:diety/features/Admin/view/AdminHome.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Auth/cubit/auth_cubit.dart';
import 'package:diety/features/Auth/widgets/login_form_fields.dart';
import 'package:diety/features/Auth/widgets/login_social_and_footer.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/Auth/views/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomSnackBar.show(
            context,
            message: "Logged in successfully! Welcome back!",
            isSuccess: true,
          );
          _handlePostLoginNavigation(state.user);
        } else if (state is AuthFailure) {
          CustomSnackBar.show(
            context,
            message: state.errorMessage,
            isSuccess: false,
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;

        return Form(
          key: formKey,
          child: Column(
            children: [
              LoginFormFields(
                emailController: emailController,
                passwordController: passwordController,
                isNotVisible: isNotVisible,
                isLoading: isLoading,
                onToggleVisibility: () {
                  setState(() {
                    isNotVisible = !isNotVisible;
                  });
                },
                onForgotPassword: () {
                  final String email = emailController.text.trim();
                  if (email.isEmpty) {
                    CustomSnackBar.show(
                      context,
                      message: "Please enter your email first",
                      isSuccess: false,
                    );
                    return;
                  }
                  if (!email.toLowerCase().endsWith('@gmail.com')) {
                    CustomSnackBar.show(
                      context,
                      message: "Only @gmail.com emails are allowed",
                      isSuccess: false,
                    );
                    return;
                  }

                  context.read<AuthCubit>().sendPasswordResetEmail(email);
                  CustomSnackBar.show(
                    context,
                    message: "Reset link requested if email exists",
                    isSuccess: true,
                  );
                },
                onLogin: () async {
                  if (!await _checkInternetConnectivity()) {
                    CustomSnackBar.show(
                      context,
                      message: "No internet connection available",
                      isSuccess: false,
                    );
                    return;
                  }

                  if (formKey.currentState!.validate()) {
                    context.read<AuthCubit>().loginWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
              ),
              const Gap(40),
              LoginSocialAndFooter(
                onGoogleSignIn: () =>
                    context.read<AuthCubit>().signInWithGoogle(),
                onFacebookSignIn: () =>
                    context.read<AuthCubit>().signInWithFacebook(),
                onSignUpNavigate: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUpView()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
