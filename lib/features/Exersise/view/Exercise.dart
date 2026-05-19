import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';
import '../cubit/exercise_cubit.dart';
import '../cubit/exercise_state.dart';
import 'DayDetailsScreen.dart';
import '../widget/Container_Exercise.dart';

class Exercise extends StatelessWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseCubit()..fetchExerciseData(),
      child: const ExerciseView(),
    );
  }
}

class ExerciseView extends StatelessWidget {
  const ExerciseView({Key? key}) : super(key: key);

  String _getHealthState(double? prediction) {
    if (prediction == null) return 'Loading...';
    if (prediction == 1.0) return 'Severely Underweight';
    if (prediction == 2.0) return 'Underweight';
    if (prediction == 3.0) return 'Mildly Underweight';
    if (prediction == 4.0) return 'Normal Weight';
    if (prediction == 5.0) return 'Overweight';
    if (prediction == 6.0 || prediction == 7.0) return 'Obesity';
    return 'Unknown';
  }

  String _getAdvanceHealthState(double? prediction) {
    if (prediction == null) return 'Loading...';
    if (prediction == 1.0) {
      return 'This Program is for People with Severely Underweight. It is designed to help you Gain Weight and build muscle.';
    }
    if (prediction == 2.0) {
      return 'This Program is for People with Underweight. It is designed to help you Gain Weight and build muscle.';
    }
    if (prediction == 3.0) {
      return 'This Program is for People with Mildly Underweight. It is designed to help you to Maintain Weight and build muscle.';
    }
    if (prediction == 4.0) {
      return 'This Program is for People with Normal Weight. It is designed to maintain your current physique and enhance endurance.';
    }
    if (prediction == 5.0) {
      return 'This Program is for People with Overweight. It is designed to help you Lose Weight and build muscle.';
    }
    if (prediction == 6.0 || prediction == 7.0) {
      return 'This Program is for People with Obesity. It is designed to help you Lose Weight and build muscle.';
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Exercise Plan',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.background,
      ),
      body: BlocBuilder<ExerciseCubit, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseInitial || state is ExerciseLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.button,
              ),
            );
          } else if (state is ExerciseError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
                    const Gap(16),
                    Text(
                      'Oops! Something went wrong.',
                      style: TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Gap(8),
                    Text(
                      state.message,
                      style: TextStyle(color: AppColors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ExerciseCubit>().fetchExerciseData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                      ),
                      child: const Text('Try Again', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ExerciseLoaded) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Health State : ${_getHealthState(state.predictionResult)}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      _getAdvanceHealthState(state.predictionResult),
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    
                    // Dynamically render all 7 days
                    ...state.daysData.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic>? dayData = entry.value;

                      if (dayData == null) return const SizedBox.shrink();

                      return Column(
                        children: [
                          Container_Exercise(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => DayDetailsScreen(
                                  dayName: 'Day ${index + 1}',
                                  dayData: dayData,
                                ),
                              ));
                            },
                            Day: 'Day ${index + 1}',
                            activity1: dayData['Activity1'] ?? '',
                            activity2: dayData['Activity2'] ?? '',
                            activity3: dayData['Activity3'] ?? '',
                            description1: dayData['Description1'] ?? '',
                            description2: dayData['Description2'] ?? '',
                            description3: dayData['Description3'] ?? '',
                            duration1: dayData['Duration1'] ?? '',
                            duration2: dayData['Duration2'] ?? '',
                            duration3: dayData['Duration3'] ?? '',
                            image: dayData['image'] ?? '',
                          ),
                          const Gap(15),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
