import 'package:diety/Core/model/UserInfoProvider.dart';
import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Container_Activites.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Asks/cubit/user_info_cubit.dart';
import 'package:diety/features/Asks/cubit/user_info_state.dart';
import 'package:diety/features/Asks/view/Age.dart';
import 'package:diety/features/User_Detials/view/UserDitails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class Activates extends StatelessWidget {
  const Activates({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInfoCubit, UserInfoState>(
      builder: (context, state) {
        final cubit = context.read<UserInfoCubit>();
        final String currentActivity = cubit.activity;

        final List<bool> isSelected = [
          currentActivity == 'Sedentary',
          currentActivity == 'Lightly Active',
          currentActivity == 'Moderately Active',
          currentActivity == 'Very Active',
          currentActivity == 'Extra Active',
        ];

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Age(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.text,
                size: 30,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Countainer_activites(
                    onTap: () {
                      cubit.selectActivity('Sedentary');
                    },
                    color:
                        isSelected[0] ? AppColors.button : AppColors.background,
                    height: 130,
                    title: 'Sedentary 🪑',
                    text: '''for people who spent most of their time
sitting or lying down ex: Programmer, Bank
Teller, Office Admin''',
                  ),
                  const Gap(15),
                  Countainer_activites(
                    onTap: () {
                      cubit.selectActivity('Lightly Active');
                    },
                    color:
                        isSelected[1] ? AppColors.button : AppColors.background,
                    height: 150,
                    title: 'Lightly Active 🚶',
                    text: '''for people who engage in light physical
activities throughout the day, such as
walking or household chores ex: Teacher
Salesman, school student''',
                  ),
                  const Gap(15),
                  Countainer_activites(
                    onTap: () {
                      cubit.selectActivity('Moderately Active');
                    },
                    color:
                        isSelected[2] ? AppColors.button : AppColors.background,
                    height: 150,
                    title: 'Moderately Active 🏃',
                    text: '''For people who participate in moderate      
physical activities regularly, such as
cycling, or playing sports ex: Personal
Trainer, Waiter University student''',
                  ),
                  const Gap(15),
                  Countainer_activites(
                    onTap: () {
                      cubit.selectActivity('Very Active');
                    },
                    color:
                        isSelected[3] ? AppColors.button : AppColors.background,
                    height: 180,
                    title: 'Very Active 🐎',
                    text: '''For people who engage in intense physical
activities on a daily basis, such as high-
intensity workouts, competitive sports, or
physically demanding occupations
ex: Athlete, Construction, Fitness Instructor''',
                  ),
                  const Gap(15),
                  Countainer_activites(
                    onTap: () {
                      cubit.selectActivity('Extra Active');
                    },
                    color:
                        isSelected[4] ? AppColors.button : AppColors.background,
                    height: 200,
                    title: 'Extra active 🏋️',
                    text: '''For people who have an exceptionally active
lifestyle, involving vigorous physical
activities for extended periods, such as
professional athletes or individuals with
physically demanding jobs ex: policeman,
firefighter''',
                  ),
                  const SizedBox(height: 20),
                  Custom_Button(
                    text: 'Body Details',
                    onPressed: () async {
                      await cubit.saveActivity();

                      // Update legacy provider
                      final userInfoProvider =
                          Provider.of<UserInfoProvider>(context, listen: false);
                      userInfoProvider.updateUserInfo(
                        activity: cubit.activity,
                      );

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const UserDitails(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
