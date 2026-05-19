// ignore_for_file: use_build_context_synchronously

import 'package:diety/Core/utils/snack_bar.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Auth/cubit/auth_cubit.dart';
import 'package:diety/features/Auth/widgets/signup_footer.dart';
import 'package:diety/features/Auth/widgets/signup_form_fields.dart';
import 'package:diety/features/Auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          CustomSnackBar.show(
            context,
            message: "Account created successfully! Welcome!",
            isSuccess: true,
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Gender()),
            (route) => false,
          );
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
              SignupFormFields(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                isNotVisible: isNotVisible,
                isLoading: isLoading,
                onToggleVisibility: () {
                  setState(() {
                    isNotVisible = !isNotVisible;
                  });
                },
                onSignUp: () {
                  if (formKey.currentState!.validate()) {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      CustomSnackBar.show(
                        context,
                        message: "Passwords do not match",
                        isSuccess: false,
                      );
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
              ),
              const Gap(20),
              SignupFooter(
                onLoginNavigate: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginView()),
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
