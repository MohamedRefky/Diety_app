import 'package:diety/Auth/Login.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/Core/Custom_TextFormFeale.dart';
import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

bool isNotVisable = true;
final formKey = GlobalKey<FormState>();
class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create an Account',
                  style: TextStyle(fontSize: 30, color: AppColors.text),
                ),
                const SizedBox(
                  height: 30,
                ),
                 CusomTextFormFeald(
                   validator: (value) {
                      if (value!.isEmpty) {
                        return 'PLease Enter Your Name';
                      }
                      return null;
                    },
                  prefixIcon: Icons.person,
                  lable: 'Name',
                ),
                const SizedBox(
                  height: 20,
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
                ),
                const SizedBox(
                  height: 20,
                ),
                CusomTextFormFeald(
                   validator: (value) {
                      if (value!.isEmpty) {
                        return 'PLease Enter Your Password';
                      }
                      return null;
                    },
                  obscureText: isNotVisable,
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
                          : Icons.remove_red_eye_rounded),color: AppColors.text,),
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Button(text: 'Sign Up', onPressed: () {}),
                Row(
                    children: [
                      Text('Already I have account',
                          style: TextStyle(
                              color: AppColors.text,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Login()));
                          },
                          child: Text(
                            'Login',
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
    );
  }
}
