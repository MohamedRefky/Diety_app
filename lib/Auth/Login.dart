import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:diety/Auth/SignUp.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/Core/Custom_TextFormFeale.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

bool isNotVisable = true;

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

//google signin
Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser==null) {
    return ;
  }
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
await FirebaseAuth.instance.signInWithCredential(credential);
  Navigator.of(context).pushNamedAndRemoveUntil("Gender", (route) => false);
}

//-----------------------------------------------------------


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
                    mycontroller: email,
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
                    mycontroller: password,
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
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                            if (credential.user!.emailVerified) {
                              Navigator.of(context)
                                  .pushReplacementNamed('Gender');
                            } else {
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                title: 'email worning',
                                desc: 'please verfiy your email ♥',
                              ).show();
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              // ignore: avoid_print
                              print('No user found for that email.');
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'email Error',
                                desc: 'No user found for that email',
                              ).show();
                            } else if (e.code == 'wrong-password') {
                              // ignore: avoid_print
                              print('Wrong password provided for that user.');
                              AwesomeDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'password Error',
                                desc: 'Wrong password provided for that user',
                              ).show();
                            }
                          }
                        }
                      }),
                      const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: AppColors.text,
              onPressed: () {
                signInWithGoogle();
              },),
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
