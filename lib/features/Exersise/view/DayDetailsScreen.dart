import 'package:diety/features/Exersise/widget/day_details_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../Core/utils/Colors.dart';
import '../extensions/day_data_extension.dart';
import '../widget/completion_dialog.dart';
import '../widget/day_details_header.dart';
import '../widget/exercise_card.dart';
import '../widget/stat_card.dart';

class DayDetailsScreen extends StatelessWidget {
  final String dayName;
  final Map<String, dynamic> dayData;

  const DayDetailsScreen({
    Key? key,
    required this.dayName,
    required this.dayData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activities = dayData.validActivities;
    final imageUrl = dayData.imageUrl;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          DayDetailsSliverAppBar(imageUrl: imageUrl),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                DayDetailsHeader(dayName: dayName),
                const Gap(24),

                // Stats Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatCard(
                      icon: Icons.fitness_center,
                      value: '${activities.length}',
                      label: 'Exercises',
                    ),
                    StatCard(
                      icon: Icons.timer_outlined,
                      value: activities.isNotEmpty ? '30-45' : '0',
                      label: 'Est. Mins',
                    ),
                    const StatCard(
                      icon: Icons.local_fire_department_outlined,
                      value: '250',
                      label: 'Est. Calories',
                    ),
                  ],
                ),
                const Gap(32),

                // Exercises Title
                Text(
                  'Exercises Routine',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(16),

                // Exercise Checklist Cards
                if (activities.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'Rest Day! Give your muscles some time to recover. 🛌',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  ...activities.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final act = entry.value;
                    return ExerciseCard(
                      index: idx + 1,
                      name: act['name']!,
                      duration: act['duration']!,
                      description: act['description']!,
                    );
                  }).toList(),

                const Gap(24),

                // Bottom Action Button
                if (activities.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ElevatedButton(
                      onPressed: () => showCompletionDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline),
                          Gap(8),
                          Text(
                            'Complete Workout',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
