import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/view/Gender.dart';
import 'package:diety/features/Asks/view/Weight.dart';
import 'package:diety/features/Asks/widget/textFormfield.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  TextEditingController heightController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Gender(),
            ));
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
                Text(
                  "What's your height ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
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
                  mycontroller: heightController,
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
                  hintText: 'Enter your Height',
                ),
                const SizedBox(
                  height: 30,
                ),
                Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Weight(),
                      ));
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
