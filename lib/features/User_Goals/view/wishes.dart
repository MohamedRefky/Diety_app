import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/Core/widget/Custom_Button.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/User_Detials/view/UserDitails.dart';
import 'package:diety/features/User_Goals/Widget/Container_Goal.dart';
import 'package:diety/features/User_Goals/cubit/user_goals_cubit.dart';
import 'package:diety/features/User_Goals/cubit/user_goals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class Wishes extends StatefulWidget {
  const Wishes({super.key});

  @override
  State<Wishes> createState() => _WishesState();
}

class _WishesState extends State<Wishes> {
  @override
  void initState() {
    super.initState();
    // Fetch user details and initialize in default Lose Mode
    context.read<UserGoalsCubit>().init(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserGoalsCubit, UserGoalsState>(
      listener: (context, state) {
        if (state.status == UserGoalsStatus.success) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } else if (state.status == UserGoalsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == UserGoalsStatus.loading ||
            state.status == UserGoalsStatus.initial) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final cubit = context.read<UserGoalsCubit>();
        final selectedIndex = state.selectedIndex;

        final options = state.isLoseMode
            ? [
                'Lose 0.25 Kg per week',
                'Lose 0.5 Kg per week (Recommended)',
                'Lose 0.75 Kg per week',
                'Lose 1 Kg per week'
              ]
            : [
                'Gain 0.25 Kg per week',
                'Gain 0.5 Kg per week (Recommended)',
                'Gain 0.75 Kg per week',
                'Gain 1 Kg per week'
              ];

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const UserDitails(),
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
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Determine your Goal',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                          fontSize: 30,
                        ),
                      ),
                      const Gap(30),

                      // Beautiful Pill Sliding Toggle
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          border:
                              Border.all(color: AppColors.button, width: 1.5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => cubit.toggleGoalMode(true),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: state.isLoseMode
                                        ? AppColors.button
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: Text(
                                    'Lose Weight',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => cubit.toggleGoalMode(false),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: !state.isLoseMode
                                        ? AppColors.button
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: Text(
                                    'Gain Weight',
                                    style: TextStyle(
                                      color: AppColors.text,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(40),

                      Text(
                        'What is your weekly goal?',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(20),

                      // Dynamic options list
                      ...options.asMap().entries.map((entry) {
                        final index = entry.key;
                        final text = entry.value;
                        final isSelected = selectedIndex == index;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container_Goal(
                            onTap: () => cubit.selectGoalIndex(index),
                            color: isSelected
                                ? AppColors.button
                                : AppColors.background,
                            text: text,
                          ),
                        );
                      }),
                      const Gap(30),
                      Custom_Button(
                        width: double.infinity,
                        text: 'Continue',
                        onPressed: () {
                          if (selectedIndex != -1) {
                            cubit.saveGoal();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Please Select Your Goal'),
                              ),
                            );
                          }
                        },
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              ),
              if (state.status == UserGoalsStatus.saving)
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
}
