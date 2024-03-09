import 'package:diety/Asks/Height.dart';
import 'package:diety/Auth/Login.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class Gender extends StatefulWidget {
  const Gender({super.key});

  @override
  State<Gender> createState() => _GenderState();
}

bool isMale = true;

class _GenderState extends State<Gender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Login(),
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
                "Choose your gender.. ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Lottie.asset(('Images/Gender.json'))),
              //  const Image(image: AssetImage('Images/gender.jpg')),
              SizedBox(
                width: 320,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: AppColors.button, width: 2),
                        backgroundColor:
                            (isMale) ? AppColors.button : AppColors.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Male',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              const Gap(15),
              SizedBox(
                width: 320,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: AppColors.button, width: 2),
                        backgroundColor:
                            (!isMale) ? AppColors.button : AppColors.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Female',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              const Gap(30),
              Custom_Button(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Height(),
                    ));
                  })
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
