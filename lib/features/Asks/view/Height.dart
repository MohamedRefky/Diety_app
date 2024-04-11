// ignore_for_file: avoid_print

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Asks/view/Weight.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  // Firestore instance
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TextEditingController for height input
  final TextEditingController _heightController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Function to save height data to Firestore
  // Future<void> _saveHeightToFirestore() async {
  //   try {
  //     // Check if the user is signed in
  //     if (FirebaseAuth.instance.currentUser == null) {
  //       print('User is not signed in');
  //       // Handle the case where the user is not signed in
  //       return;
  //     }

  //     // Get current user's UID
  //     String uid = FirebaseAuth.instance.currentUser!.uid;

  //     // Get height value from text field
  //     String height = _heightController.text;

  //     // Add height data to Firestore
  //     await _firestore.collection('users').doc(uid).set({
  //       'height': height,
  //     });

  //     // Log success message
  //     print('Height data saved to Firestore');
  //   } catch (error) {
  //     // Log error message
  //     print('Error saving height data: $error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Gender(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.text,
            size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "What's your height ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const Gap(10),
                const SizedBox(
                  width: double.infinity,
                  height: 290,
                  child: Image(image: AssetImage('Images/height2.jpg')),
                ),
                const Gap(30),
                textFormField(
                    hintText: 'Enter your Height',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Your Height';
                      } else {
                        final height = double.tryParse(value);
                        if (height == null || height < 90 || height > 210) {
                          return 'Please Enter A Valid Height';
                        }
                      }
                      return null;
                    },
                    mycontroller: _heightController),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    // _saveHeightToFirestore(); // Call function to save height to Firestore
                    if(formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Weight(),
                      ),
                    );
                    }
                    
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
