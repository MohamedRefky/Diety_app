import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/view/Activates.dart';
import 'package:diety/features/User%20Detials/widget/viewDitails.dart';
import 'package:diety/features/User%20Detials/wishes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class UserDitails extends StatelessWidget {
  const UserDitails({super.key});
 
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfoProvider>(context).userInfo;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Body Details',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.white,
            fontSize: 25,
          ),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 300,
                    height: 280,
                    child: Lottie.asset(
                      'Images/Ditails_Animation.json',
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userInfo.gender,
                      style: TextStyle(color: AppColors.white),
                    ),
                    Text(userInfo.height.toString(),
                        style: TextStyle(color: AppColors.white)),
                    Text(userInfo.weight.toString(),
                        style: TextStyle(color: AppColors.white)),
                    Text(userInfo.activity,
                        style: TextStyle(color: AppColors.white)),
                    Text(userInfo.age.toString(),
                        style: TextStyle(color: AppColors.white))
                  ],
                ),
                customRowVeiwDitails(
                  userInfo: userInfo,
                  title: 'Your daily calorie needed :',
                  value: userInfo.dailyCalories.toStringAsFixed(1),
                ),
                const Gap(15),
                customRowVeiwDitails(
                  userInfo: userInfo,
                  title: 'Your Body Mass Index (BMI) :',
                  value: userInfo.calculateBMI().toStringAsFixed(1),
                ),
                const Gap(15),
                customRowVeiwDitails(
                  userInfo: userInfo,
                  title: 'Health Status :',
                  value: userInfo.calculateAndDetermineBMI().toString(),
                ),
                const Gap(15),
                customRowVeiwDitails(
                  userInfo: userInfo,
                  title: 'Ideal Weight :',
                  value:
                      '${userInfo.calculateIdealWeight().toStringAsFixed(1)} kg',
                ),
                const Gap(15),
                customRowVeiwDitails(
                  userInfo: userInfo,
                  title: 'Water Intake :',
                  value:
                      '${userInfo.calculateWaterIntake().toStringAsFixed(1)} L',
                ),
                const Gap(15),
                customRowVeiwDitails(
                  userInfo: userInfo,
                  title: 'Optimal Sleep Duration :',
                  value: '${userInfo.calculateOptimalSleepDuration()} hrs',
                ),
                const Gap(50),
                Custom_Button(
                    width: 300,
                    text: 'My Plane',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Wishes(),
                      ));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
