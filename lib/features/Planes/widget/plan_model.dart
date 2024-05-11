import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  final String name;
  final String details;
  final String image;
  final String guidelines;
  final String duration;
  final String difficulty;
  final List<String> chooseThisPlanIf;
  final List<String> whatYouWillDo;
  final Map<String, String> schedule; // Adding the schedule as a Map

  Plan({
    required this.guidelines,
    required this.name,
    required this.details,
    required this.image,
    required this.duration,
    required this.difficulty,
    required this.chooseThisPlanIf,
    required this.whatYouWillDo,
    required this.schedule,
    // Require it in the constructor
  });

//   factory Plan.fromFirestore(Map<String, dynamic> firestore) {
//     // Convert schedule map from dynamic to Map<String, String>
//     Map<String, String> scheduleMap = {};
//     if (firestore['schedule'] != null) {
//       firestore['schedule'].forEach((key, value) {
//         scheduleMap[key] = value.toString();
//       });
//     }

//     return Plan(
//       name: firestore['name'] ?? 'N/A',
//       details: firestore['details'] ?? 'N/A',
//       image: firestore['image'] ?? 'https://placehold.it/150x150',
//       duration: firestore['Duration'] ?? 'N/A',
//       difficulty: firestore['Difficulty'] ?? 'N/A',
//       chooseThisPlanIf:
//           List<String>.from(firestore['Choose This Plan If'] ?? []),
//       whatYouWillDo: List<String>.from(firestore['What You Will Do'] ?? []),
//       schedule: scheduleMap,
//       guidelines:
//           firestore['Guidelines'] ?? [], // Assign the converted schedule map
//     );
//   }
// }
  factory Plan.fromFirestore(Map<String, dynamic> firestore) {
    // Convert schedule map from dynamic to Map<String, String>
    Map<String, String> scheduleMap = {};
    if (firestore['schedule'] != null) {
      firestore['schedule'].forEach((key, value) {
        scheduleMap[key] = value.toString();
      });
    }

    return Plan(
      name: firestore['name'] ?? 'N/A',
      details: firestore['details'] ?? 'N/A',
      image: firestore['image'] ?? 'https://placehold.it/150x150',
      duration: firestore['Duration'] ?? 'N/A',
      difficulty: firestore['Difficulty'] ?? 'N/A',
      chooseThisPlanIf:
          List<String>.from(firestore['Choose This Plan If'] ?? []),
      whatYouWillDo: List<String>.from(firestore['What You Will Do'] ?? []),
      schedule: scheduleMap,
      guidelines: firestore['Guidelines'] ??
          '', // Assign a default value if it's not a String
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Plan>> getPlans() {
    return _db.collection('fitnessPlans').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Plan.fromFirestore(doc.data()))
              .toList(),
        );
  }
}
