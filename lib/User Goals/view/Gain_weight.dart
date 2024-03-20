import 'package:diety/Core/Colors.dart';
import 'package:diety/Core/Custom_Button.dart';
import 'package:diety/User%20Detials/wishes.dart';
import 'package:diety/User%20Goal/Widget/Container_Goal.dart';
import 'package:diety/User%20Plane/plane.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class gain_Weight extends StatefulWidget {
  const gain_Weight({super.key});

  @override
  State<gain_Weight> createState() => _gain_WeightState();
}

List<bool> isSelected = List.generate(4, (index) => false);

class _gain_WeightState extends State<gain_Weight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Wishes(),
              ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.text,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'What is your weekly goal',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontSize: 30,
              ),
            ),
            const Gap(60),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [true, false, false, false];
                });
              },
              color: isSelected[0] ? AppColors.button : AppColors.background,
              text: 'Gain 0.25 Kg per week',
            ),
            const Gap(15),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [false, true, false, false];
                });
              },
              color: isSelected[1] ? AppColors.button : AppColors.background,
              text: 'Gain 0.5 Kg per week (Recommended)',
            ),
            const Gap(15),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [false, false, true, false];
                });
              },
              color: isSelected[2] ? AppColors.button : AppColors.background,
              text: 'Gain 0.75 Kg per week',
            ),
            const Gap(15),
            Container_Goal(
              onTap: () {
                setState(() {
                  isSelected = [false, false, false, true];
                });
              },
              color: isSelected[3] ? AppColors.button : AppColors.background,
              text: 'Gain 1 Kg per week',
            ),
            const Gap(40),
            Custom_Button(
                width: double.infinity,
                text: 'Continue',
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Plane(),
                  ));
                })
          ],
        ),
      ),
    );
  }
}
