import 'package:diety/features/Asks/Activates.dart';
import 'package:diety/features/Asks/Weight.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class Age extends StatefulWidget {
  const Age({super.key});

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  var date = DateFormat.yMd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Weight(),
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
                  Text(
                    "What's your age ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                      width: double.infinity,
                      height: 290,
                      child: Image(image: AssetImage('Images/age.jpg'))),
                 
                  TextFormField(
                    //readOnly: true,
                    onTap: () {
                  
                    },
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: AppColors.text),
                    decoration: InputDecoration(
                        // suffixIcon: Icon(
                        //   Icons.calendar_month,
                        //   color: AppColors.white,
                        // ),
                        hintText: 'Enter Your age',
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
                          builder: (context) => const Activates(),
                        ));
                      })
                ]),
          ),
        ));
  }
}
