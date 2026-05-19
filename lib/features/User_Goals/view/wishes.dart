import 'package:diety/Core/utils/Colors.dart';
import 'package:diety/features/Home/view/view/Home.dart';
import 'package:diety/features/User_Detials/view/UserDitails.dart';
import 'package:diety/features/User_Goals/Widget/GoalHeaderToggle.dart';
import 'package:diety/features/User_Goals/Widget/GoalPaceSelector.dart';
import 'package:diety/features/User_Goals/cubit/user_goals_cubit.dart';
import 'package:diety/features/User_Goals/cubit/user_goals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishes extends StatelessWidget {
  const Wishes({super.key});

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
            ? const [
                'Lose 0.25 Kg per week',
                'Lose 0.5 Kg per week (Recommended)',
                'Lose 0.75 Kg per week',
                'Lose 1 Kg per week'
              ]
            : const [
                'Gain 0.25 Kg per week',
                'Gain 0.5 Kg per week (Recommended)',
                'Gain 0.75 Kg per week',
                'Gain 1 Kg per week'
              ];

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GoalHeaderToggle(
                        isLoseMode: state.isLoseMode,
                        onToggle: cubit.toggleGoalMode,
                      ),
                      const SizedBox(height: 40),
                      GoalPaceSelector(
                        options: options,
                        selectedIndex: selectedIndex,
                        onSelect: cubit.selectGoalIndex,
                        onContinue: () {
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
                      const SizedBox(height: 20),
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
