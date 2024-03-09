import 'package:diety/Asks/Activates.dart';
import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Wishes extends StatefulWidget {
  const Wishes({super.key});

  @override
  State<Wishes> createState() => _WishesState();
}

bool isLose = true;

class _WishesState extends State<Wishes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Activates(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.text,
              size: 30,
            )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You Want To ..!',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 30,
                ),
              ),
              const Gap(40),
              SizedBox(
                width: 320,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLose = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: AppColors.button, width: 2),
                        backgroundColor:
                            (isLose) ? AppColors.button : AppColors.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Gain Weight',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              const Gap(20),
              SizedBox(
                width: 320,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLose = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        side: BorderSide(color: AppColors.button, width: 2),
                        backgroundColor:
                            (!isLose) ? AppColors.button : AppColors.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Lose Weight',
                      style: TextStyle(
                          color: AppColors.text,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    )),
              ),
                            const Gap(60),
              Custom_Button(
                width: double.infinity,
                  text: 'Continue',
                  onPressed: () {
                    
                  })
            ],
          ),
        ),
      ),
    );
  }
}
