// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:diety/Core/model/UserInfo.dart';
import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/view/Activates.dart';
import 'package:diety/features/User_Detials/widget/viewDitails.dart';
import 'package:diety/features/User_Goals/view/wishes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/User_Detials/cubit/user_details_cubit.dart';
import 'package:diety/features/User_Detials/cubit/user_details_state.dart';

class UserDitails extends StatelessWidget {
  const UserDitails({super.key});

  @override
  Widget build(BuildContext context) {
    final infoCubit = context.read<UserInfoCubit>();
    final initialInfo = UserInfo(
      gender: infoCubit.gender,
      height: infoCubit.height,
      weight: infoCubit.weight,
      age: infoCubit.age,
      activity: infoCubit.activity,
    );

    return BlocProvider<UserDetailsCubit>(
      create: (context) => UserDetailsCubit(initialInfo)
        ..loadUserDetails(
          gender: infoCubit.gender,
          height: infoCubit.height,
          weight: infoCubit.weight,
          age: infoCubit.age,
          activity: infoCubit.activity,
        ),
      child: const UserDetailsView(),
    );
  }
}

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDetailsCubit, UserDetailsState>(
      listener: (context, state) {
        if (state is UserDetailsLoaded) {
          // Sync with legacy provider in the background
          final info = state.userInfo;
          Provider.of<UserInfoProvider>(context, listen: false).updateUserInfo(
            gender: info.gender,
            height: info.height,
            weight: info.weight,
            age: info.age,
            activity: info.activity,
          );
        } else if (state is UserDetailsSaveSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Wishes(),
          ));
        } else if (state is UserDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        UserInfo userInfo;
        bool isSaving = false;

        if (state is UserDetailsLoaded) {
          userInfo = state.userInfo;
        } else if (state is UserDetailsSaving) {
          userInfo = state.userInfo;
          isSaving = true;
        } else if (state is UserDetailsSaveSuccess) {
          userInfo = state.userInfo;
        } else {
          // Fallback during initialization
          userInfo = UserInfo(
            gender: 'Male',
            height: 170,
            weight: 70,
            age: 25,
            activity: 'Lightly Active',
          );
        }

        final double bmiVal = userInfo.calculateBMI();

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
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularPercentIndicator(
                          animationDuration: 1800,
                          animation: true,
                          radius: 100,
                          lineWidth: 20,
                          percent: (bmiVal / 100).clamp(0.0, 1.0),
                          progressColor: AppColors.button,
                          backgroundColor: AppColors.grey,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bmiVal.toStringAsFixed(1),
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              Text(
                                'bmi',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        AnimatedTextKit(
                          key: ValueKey(bmiVal),
                          animatedTexts: [
                            TypewriterAnimatedText(
                                "Health Status is ${userInfo.calculateAndDetermineBMI()}",
                                textStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white),
                                speed: const Duration(milliseconds: 100)),
                          ],
                          totalRepeatCount: 1,
                          stopPauseOnTap: true,
                          displayFullTextOnTap: true,
                        ),
                        const Gap(10),
                        customRowVeiwDitails(
                          title: 'Your daily calories :',
                          value: userInfo.dailyCalories.toStringAsFixed(1),
                        ),
                        const Gap(15),
                        customRowVeiwDitails(
                          title: 'Your (BMI) :',
                          value: bmiVal.toStringAsFixed(1),
                        ),
                        const Gap(15),
                        customRowVeiwDitails(
                          title: 'Ideal Weight :',
                          value:
                              '${userInfo.calculateIdealWeight().toStringAsFixed(1)} kg',
                        ),
                        const Gap(15),
                        customRowVeiwDitails(
                          title: 'Water Intake :',
                          value:
                              '${userInfo.calculateWaterIntake().toStringAsFixed(1)} L',
                        ),
                        const Gap(15),
                        customRowVeiwDitails(
                          title: 'Optimal Sleep Duration :',
                          value:
                              '${userInfo.calculateOptimalSleepDuration()} hrs',
                        ),
                        const Gap(15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.button.withValues(alpha: 0.4),
                                AppColors.button.withValues(alpha: 0.5),
                                AppColors.button.withValues(alpha: 1.0),
                              ],
                              stops: const [0.0, 0.75, 1.0],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Advice For You !",
                                  style: TextStyle(
                                      color: AppColors.white,
                                      decoration: TextDecoration.underline,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 22,
                                ),
                                Text(
                                  showDetailedAdvice(bmiVal),
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Gap(40),
                        Custom_Button(
                            width: 300,
                            text: 'Determine Goal',
                            onPressed: () {
                              context.read<UserDetailsCubit>().saveGoal(
                                    userInfo: userInfo,
                                  );
                            })
                      ],
                    ),
                  ),
                ),
              ),
              if (isSaving)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  String showDetailedAdvice(double bmi) {
    if (bmi < 16.0) {
      return "Severely Underweight. It's critical to seek medical attention immediately. Rapid weight loss can indicate serious health issues. Consult with a healthcare professional to address underlying causes and develop a safe and effective plan for weight gain.";
    } else if (bmi >= 16.0 && bmi < 16.9) {
      return "Underweight. Although not severely underweight, it's essential to address any unintentional weight loss. Focus on increasing calorie intake through balanced meals and snacks. Incorporate strength training exercises to build muscle mass and improve overall health.";
    } else if (bmi >= 17.0 && bmi < 18.4) {
      return "Mildly Underweight. While not severely underweight, it's important to pay attention to nutrition and overall health. Aim for a balanced diet rich in nutrient-dense foods and consider consulting with a dietitian to develop a personalized eating plan.";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal Weight. Congratulations on maintaining a healthy weight! Continue to prioritize healthy eating habits and regular physical activity to support overall well-being.";
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return "Overweight. It's important to focus on gradual weight loss to reduce health risks associated with excess weight. Incorporate more fruits, vegetables, and whole grains into your diet, and aim for at least 150 minutes of moderate-intensity exercise per week.";
    } else if (bmi >= 30.0 && bmi < 34.9) {
      return "Obesity class I. Take proactive steps to manage your weight and improve your health. Work with a healthcare professional to develop a comprehensive plan that includes dietary changes, increased physical activity, and behavior modification strategies.";
    } else if (bmi >= 35.0 && bmi < 39.9) {
      return "Obesity class II. This is a serious health condition requiring professional intervention. Consideration of medical treatments, such as medication or bariatric surgery, may be necessary. Seek guidance from healthcare providers specializing in obesity management.";
    } else {
      return "Obesity class III. Also known as morbid obesity, this is a severe health condition requiring urgent medical attention. Immediate intervention is necessary to reduce the risk of associated health complications. Consult with healthcare specialists experienced in managing severe obesity.";
    }
  }
}
