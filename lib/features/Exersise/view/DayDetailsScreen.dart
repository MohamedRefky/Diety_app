import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../Core/utils/Colors.dart';
import '../widget/completion_dialog.dart';
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
    // Collect non-empty activities dynamically
    final List<Map<String, String>> activities = [];
    for (int i = 1; i <= 3; i++) {
      final String activityKey = 'Activity$i';
      final String durationKey = 'Duration$i';
      final String descKey = 'Description$i';

      final String activity = (dayData[activityKey] ?? '').toString().trim();
      final String duration = (dayData[durationKey] ?? '').toString().trim();
      final String desc = (dayData[descKey] ?? '').toString().trim();

      if (activity.isNotEmpty && activity != 'null') {
        activities.add({
          'name': activity,
          'duration':
              duration.isNotEmpty && duration != 'null' ? duration : 'N/A',
          'description': desc.isNotEmpty && desc != 'null'
              ? desc
              : 'No description provided.',
        });
      }
    }

    final String imageUrl = (dayData['image'] ?? '').toString().trim();
    const String fallbackUrl =
        'https://buzzrx.s3.amazonaws.com/d1c6326d-04b2-48f9-95df-9e5d2b492bfe/WhyDoExerciseNeedsVaryBetweenIndividuals.png';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero Image Header
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl.isNotEmpty ? imageUrl : fallbackUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppColors.background,
                      child: Center(
                        child:
                            CircularProgressIndicator(color: AppColors.button),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.network(
                      fallbackUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Bottom gradient overlay for visual blend
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          AppColors.background.withOpacity(0.6),
                          AppColors.background,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable Content
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Header Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dayName,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.button.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.button.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.flash_on,
                              color: AppColors.button, size: 16),
                          const Gap(4),
                          Text(
                            'Today\'s Goal',
                            style: TextStyle(
                              color: AppColors.button,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  'Follow these exercises designed specifically for your physical condition.',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                  ),
                ),
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
                    final int idx = entry.key;
                    final Map<String, String> act = entry.value;
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
