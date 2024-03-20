import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diety/Auth/Login.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/Core/Custom_TextFormFeale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

bool isNotVisable = true;

class _SingUpState extends State<SingUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  mycontroller: username,
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
                  mycontroller: email,
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
                  mycontroller: password,
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
                        : Icons.remove_red_eye_rounded),
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Custom_Button(
                    text: 'Sign Up',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("saved successfuly"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                                )
                              );
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacementNamed("Login");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("The email address is badly formatted \n make sure that email include xxx@xxx.xx"),
                                duration: Duration(seconds: 5),
                                backgroundColor: Colors.red
                                
                                ),
                              );
                          } else if (e.code == 'weak-password') {
                            // ignore: avoid_print
                            print('The password provided is too weak.');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("The password provided is too weak \n Password should be at least 6 characters"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red
                                ),
                              );
                          } else if (e.code == 'email-already-in-use') {
                            // ignore: avoid_print
                            print('The account already exists for that email.');
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("The account already exists for that email"),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red
                                ),
                              );
                          }
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                      }
                    }),
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
