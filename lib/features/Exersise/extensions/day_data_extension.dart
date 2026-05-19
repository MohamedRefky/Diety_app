extension DayDataExtension on Map<String, dynamic> {
  List<Map<String, String>> get validActivities {
    final List<Map<String, String>> activities = [];
    for (int i = 1; i <= 3; i++) {
      final String activityKey = 'Activity$i';
      final String durationKey = 'Duration$i';
      final String descKey = 'Description$i';

      final String activity = (this[activityKey] ?? '').toString().trim();
      final String duration = (this[durationKey] ?? '').toString().trim();
      final String desc = (this[descKey] ?? '').toString().trim();

      if (activity.isNotEmpty && activity != 'null') {
        activities.add({
          'name': activity,
          'duration': duration.isNotEmpty && duration != 'null' ? duration : 'N/A',
          'description': desc.isNotEmpty && desc != 'null' ? desc : 'No description provided.',
        });
      }
    }
    return activities;
  }

  String get imageUrl {
    final String url = (this['image'] ?? '').toString().trim();
    if (url.isNotEmpty && url != 'null') return url;
    return 'https://buzzrx.s3.amazonaws.com/d1c6326d-04b2-48f9-95df-9e5d2b492bfe/WhyDoExerciseNeedsVaryBetweenIndividuals.png';
  }
}
