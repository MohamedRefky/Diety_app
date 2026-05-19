import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ExerciseCubit() : super(ExerciseInitial());

  Future<void> fetchExerciseData() async {
    emit(ExerciseLoading());

    try {
      // 1. Fetch User Data
      User? user = _auth.currentUser;
      if (user == null) {
        emit(const ExerciseError(message: 'User not logged in'));
        return;
      }

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (!userDoc.exists) {
        emit(const ExerciseError(message: 'User data not found'));
        return;
      }

      int weight = int.tryParse(userDoc.get('weight')?.toString() ?? '0') ?? 0;
      int height = int.tryParse(userDoc.get('height')?.toString() ?? '0') ?? 0;
      int age = int.tryParse(userDoc.get('age')?.toString() ?? '0') ?? 0;
      String gender = userDoc.get('gender')?.toString() ?? '';

      if (weight == 0 || height == 0 || age == 0) {
        emit(const ExerciseError(message: 'Incomplete user physical data'));
        return;
      }

      // 2. Fetch Prediction
      double? predictionResult;
      var url = Uri.parse('http://10.0.2.2:5000/predict');
      var data = {
        'Weight': [weight],
        'Height': [height],
        'Gender': [gender],
        'Age': [age]
      };

      try {
        var response = await http.post(
          url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode(data),
        ).timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          var decodedResponse = jsonDecode(response.body);
          var predictions = decodedResponse['predictions'];
          if (predictions is List && predictions.isNotEmpty) {
            predictionResult = predictions[0].toDouble();
          }
        }
      } catch (error) {
        print('Prediction API call failed or timed out: $error. Utilizing robust BMI fallback.');
      }

      // Fallback if API fails
      if (predictionResult == null) {
        double heightInMeters = height / 100.0;
        double bmi = weight / (heightInMeters * heightInMeters);

        if (bmi < 16.0) {
          predictionResult = 1.0;
        } else if (bmi < 18.5) {
          predictionResult = 2.0;
        } else if (bmi < 20.0) {
          predictionResult = 3.0;
        } else if (bmi < 25.0) {
          predictionResult = 4.0;
        } else if (bmi < 30.0) {
          predictionResult = 5.0;
        } else {
          predictionResult = 6.0;
        }
      }

      // 3. Fetch Plan from Firestore
      String plan;
      switch (predictionResult) {
        case 1.0: plan = 'plan1'; break;
        case 2.0: plan = 'plan2'; break;
        case 3.0: plan = 'plan3'; break;
        case 4.0: plan = 'plan4'; break;
        case 5.0: plan = 'plan5'; break;
        case 6.0:
        case 7.0: plan = 'plan6'; break;
        default: plan = 'plan4';
      }

      DocumentSnapshot planDoc = await _firestore.collection('exercise_plans').doc(plan).get();
      
      if (!planDoc.exists) {
        emit(ExerciseError(message: 'Exercise plan ($plan) not found in database'));
        return;
      }

      Map<String, dynamic> planData = planDoc.data() as Map<String, dynamic>;
      
      List<Map<String, dynamic>?> daysData = [
        planData['Day1'] is Map<String, dynamic> ? planData['Day1'] : null,
        planData['Day2'] is Map<String, dynamic> ? planData['Day2'] : null,
        planData['Day3'] is Map<String, dynamic> ? planData['Day3'] : null,
        planData['Day4'] is Map<String, dynamic> ? planData['Day4'] : null,
        planData['Day5'] is Map<String, dynamic> ? planData['Day5'] : null,
        planData['Day6'] is Map<String, dynamic> ? planData['Day6'] : null,
        planData['Day7'] is Map<String, dynamic> ? planData['Day7'] : null,
      ];

      emit(ExerciseLoaded(predictionResult: predictionResult, daysData: daysData));

    } catch (e) {
      emit(ExerciseError(message: 'An unexpected error occurred: $e'));
    }
  }
}
