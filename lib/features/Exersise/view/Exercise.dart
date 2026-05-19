import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';
import '../cubit/exercise_cubit.dart';
import '../cubit/exercise_state.dart';
import '../extensions/prediction_extension.dart';
import '../widget/Container_Exercise.dart';
import 'DayDetailsScreen.dart';

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
                    const Icon(Icons.error_outline,
                        color: Colors.redAccent, size: 48),
                    const Gap(16),
                    Text(
                      'Oops! Something went wrong.',
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
                      child: const Text('Try Again',
                          style: TextStyle(color: Colors.white)),
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
                      'Health State : ${state.predictionResult.healthState}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      state.predictionResult.advanceHealthState,
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
