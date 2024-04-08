
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/Gender.dart';
import 'package:diety/features/Asks/Weight.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  TextEditingController heigth = TextEditingController();
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
              )),
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
                        child: Image(image: AssetImage('Images/height2.jpg'))),
                    const Gap(30),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PLease Enter Your Height';
                        } else {
                          final height = double.tryParse(value);
                          if (height == null || height <= 100 || height > 210) {
                            return 'Please Enter A Valid Height';
                          }
                        }
                        return null;
                      },
                      controller: heigth,
                      onTap: () {},
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.text),
                      decoration: InputDecoration(
                          hintText: ' Enter your Height',
                          hintStyle:
                              TextStyle(fontSize: 20, color: AppColors.text),
                          border: const UnderlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColors.button)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: AppColors.button)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.red))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Custom_Button(
                        text: 'Continue',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Weight(),
                            ));
                          }
                        })
                  ]),
            ),
          ),
        ));
  }
}
