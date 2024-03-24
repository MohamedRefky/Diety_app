// ignore: unused_import
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diety/features/Auth/Login.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/Core/Custom_TextFormFealed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool isNotVisable = true;

class _SignUpState extends State<SignUp> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController Confirmpassword = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 40,
                        color: AppColors.text,
                        fontWeight: FontWeight.w600),
                  ),
                  const Gap(30),
                  // first and last name
                  Row(
                    children: [
                      SizedBox(
                        width: 180,
                        child: CusomTextFormFeald(
                          mycontroller: firstname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Enter Your First Name';
                            }
                            return null;
                          },
                          prefixIcon: Icons.person,
                          lable: 'First Name',
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 180,
                        child: CusomTextFormFeald(
                          mycontroller: lastname,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'PLease Enter Your Last Name';
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
                  //Email
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
                  const Gap(15),
                  //Password
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
                  const Gap(15),
                  //Confirm Password
                  CusomTextFormFeald(
                    mycontroller: Confirmpassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'PLease Enter Your Password';
                      }
                      return null;
                    },
                    obscureText: isNotVisable,
                    prefixIcon: Icons.lock,
                    lable: 'Confirm Password',
                  ),
                  const Gap(20),
                  //Sign Up Buttom
                  Custom_Button(
                    text: 'Sign Up',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          // ignore: unused_local_variable
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("saved successfuly"),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ));
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushReplacementNamed("Login");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-email') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "The email address is badly formatted \n make sure that email include xxx@xxx.xx"),
                                  duration: Duration(seconds: 5),
                                  backgroundColor: Colors.red),
                            );
                          } else if (e.code == 'weak-password') {
                            // ignore: avoid_print
                            print('The password provided is too weak.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "The password provided is too weak \n Password should be at least 6 characters"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            // ignore: avoid_print
                            print('The account already exists for that email.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "The account already exists for that email"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.red),
                            );
                          }
                        }
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  //Divider
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(color: AppColors.text),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or',
                          style: TextStyle(color: AppColors.text, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Divider(color: AppColors.text),
                      ),
                    ],
                  ),
                  const Gap(25),
                  // login with Google and facebook
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                         //await signInWithFacebook();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('Images/Google.png'),
                              )),
                        ),
                      ),
                      const Gap(10),
                      InkWell(
                        onTap: () async {
                           //await signInWithGoogle();
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                          ),
                          child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('Images/facebook.jpg'),
                              )),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                  //have Acc
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
              )),
            ),
          ),
        ),
      ),
    );
  }
}
