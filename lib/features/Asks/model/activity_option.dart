class ActivityOption {
  final String key;
  final String title;
  final String description;
  final double height;

  const ActivityOption({
    required this.key,
    required this.title,
    required this.description,
    required this.height,
  });
}

const List<ActivityOption> activityOptions = [
  ActivityOption(
    key: 'Sedentary',
    title: 'Sedentary 🪑',
    description:
        'for people who spent most of their time\nsitting or lying down ex: Programmer, Bank\nTeller, Office Admin',
    height: 130,
  ),
  ActivityOption(
    key: 'Lightly Active',
    title: 'Lightly Active 🚶',
    description:
        'for people who engage in light physical\nactivities throughout the day, such as\nwalking or household chores ex: Teacher\nSalesman, school student',
    height: 150,
  ),
  ActivityOption(
    key: 'Moderately Active',
    title: 'Moderately Active 🏃',
    description:
        'For people who participate in moderate\nphysical activities regularly, such as\ncycling, or playing sports ex: Personal\nTrainer, Waiter University student',
    height: 150,
  ),
  ActivityOption(
    key: 'Very Active',
    title: 'Very Active 🐎',
    description:
        'For people who engage in intense physical\nactivities on a daily basis, such as high-\nintensity workouts, competitive sports, or\nphysically demanding occupations\nex: Athlete, Construction, Fitness Instructor',
    height: 180,
  ),
  ActivityOption(
    key: 'Extra Active',
    title: 'Extra active 🏋️',
    description:
        'For people who have an exceptionally active\nlifestyle, involving vigorous physical\nactivities for extended periods, such as\nprofessional athletes or individuals with\nphysically demanding jobs ex: policeman,\nfirefighter',
    height: 200,
  ),
];
