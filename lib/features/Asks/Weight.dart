
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/Age.dart';
import 'package:diety/features/Asks/Height.dart';
import 'package:flutter/material.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _HeightState();
}

class _HeightState extends State<Weight> {
  TextEditingController weight = TextEditingController();
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
                  builder: (context) => const Height(),
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
                      "What's your Weight ?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                        width: double.infinity,
                        height: 290,
                        child: Image(image: AssetImage('Images/weight.jpg'))),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'PLease Enter Your Weight';
                        } else {
                          final weight = double.tryParse(value);
                          if (weight == null || weight > 300 || weight <= 20) {
                            return 'Please Enter A Valid Weight';
                          }
                        }
                        return null;
                      },
                      controller: weight,
                      onTap: () {},
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: AppColors.text),
                      decoration: InputDecoration(
                          hintText: ' Enter your Weight',
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
                              borderSide: const BorderSide(color: Colors.red))
                              
                              ),
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
                              builder: (context) => const Age(),
                            ));
                          }
                        })
                  ]),
            ),
          ),
        ));
  }
}
