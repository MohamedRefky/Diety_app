import 'package:diety/Asks/Age.dart';
import 'package:diety/Asks/Height.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:flutter/material.dart';

class Weight extends StatefulWidget {
  const Weight({super.key});

  @override
  State<Weight> createState() => _HeightState();
}

class _HeightState extends State<Weight> {
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "What is your Weight?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  const Image(image: AssetImage('Images/weight.jpg')),
                  TextFormField(
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
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Custom_Button(
                      text: 'Continue',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Age(),
                        ));
                      })
                ]),
          ),
        ));
  }
}
