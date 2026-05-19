import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Auth/cubit/auth_cubit.dart';
import 'package:diety/features/Auth/widgets/login_form.dart';
import 'package:diety/features/Auth/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: BlocProvider(
                create: (context) => AuthCubit(),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginHeader(),
                    Gap(40),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
