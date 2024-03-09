import 'package:diety/Asks/Gender.dart';
import 'package:diety/Auth/SuinUp.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/Core/Custom_TextFormFeale.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool isNotVisable = true;
final formKey = GlobalKey<FormState>();

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Image(image: AssetImage('Images/logo.jpg')),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30, color: AppColors.text),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CusomTextFormFeald(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'PLease Enter Your Email';
                      }
                      return null;
                    },
                    prefixIcon: Icons.email,
                    lable: 'Email',
                    suffixIcon: null,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CusomTextFormFeald(
                    obscureText: isNotVisable,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'PLease Enter Your Password';
                      }
                      return null;
                    },
                    prefixIcon: Icons.lock,
                    lable: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isNotVisable = !isNotVisable;
                        });
                      },
                      icon: Icon((isNotVisable)
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_rounded),
                      color: AppColors.text,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Custom_Button(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const Gender()),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text('If you don\'t have account.',
                          style: TextStyle(
                              color: AppColors.text,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SingUp()));
                          },
                          child: Text(
                            'Create one !',
                            style: TextStyle(
                                color: AppColors.button,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
