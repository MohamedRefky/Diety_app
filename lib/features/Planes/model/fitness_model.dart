/*class FitnessPlan {
  String name;
  String details;
  String duration;
  int timesPerWeek;
  String difficulty;
  List<String> chooseThisPlanIf;
  List<String> whatYouWillDo;
  String image;
  Map<String, String> schedule;
  String guidelines;  // Added new field

  FitnessPlan({
    required this.name,
    required this.details,
    required this.duration,
    required this.timesPerWeek,
    required this.difficulty,
    required this.chooseThisPlanIf,
    required this.whatYouWillDo,
    required this.image,
    required this.schedule,
    required this.guidelines
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': details,
      'duration': duration,
      'timesPerWeek': timesPerWeek,
      'difficulty': difficulty,
      'chooseThisPlanIf': chooseThisPlanIf,
      'whatYouWillDo': whatYouWillDo,
      'image': image,
      'schedule': schedule,
      'guidelines': guidelines,
    };
  }

  // Assuming a method to create an instance from a Map if needed
  factory FitnessPlan.fromMap(Map<String, dynamic> map) {
    return FitnessPlan(
      name: map['name'],
      details: map['details'],
      duration: map['duration'],
      timesPerWeek: map['timesPerWeek'],
      difficulty: map['difficulty'],
      chooseThisPlanIf: List<String>.from(map['chooseThisPlanIf']),
      whatYouWillDo: List<String>.from(map['whatYouWillDo']),
      image: map['image'],
      schedule: Map<String, String>.from(map['schedule']),
      guidelines: map['guidelines'],
    );
  }
}*/

class Plan {
  final String name;
  final String details;
  final String difficulty;
  final String duration;
  final String guidelines;
  final String image;
  final List<String> chooseThisPlanIf;
  final Map<String, dynamic> schedule;

  Plan({
    required this.name,
    required this.details,
    required this.difficulty,
    required this.duration,
    required this.guidelines,
    required this.image,
    required this.chooseThisPlanIf,
    required this.schedule,
  });

  factory Plan.fromFirestore(Map<String, dynamic> firestore) {
    return Plan(
      name: firestore['name'] as String,
      details: firestore['details'] as String,
      difficulty: firestore['difficulty'] as String,
      duration: firestore['duration'] as String,
      guidelines: firestore['guidelines'] as String,
      image: firestore['image'] as String,
      chooseThisPlanIf:
          List<String>.from(firestore['chooseThisPlanIf'] as List<dynamic>),
      schedule: Map<String, dynamic>.from(firestore['schedule'] as Map),
    );
  }
}
