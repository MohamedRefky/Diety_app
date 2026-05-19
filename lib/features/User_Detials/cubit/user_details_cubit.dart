import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/Core/model/UserInfo.dart';
import 'package:diety/features/User_Detials/cubit/user_details_state.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit(UserInfo initialInfo)
      : super(UserDetailsLoaded(initialInfo));

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loadUserDetails({
    required String gender,
    required double height,
    required double weight,
    required double age,
    required String activity,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      emit(const UserDetailsError("User is not authenticated."));
      return;
    }

    try {
      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final fetchedGender = userDoc.get('gender') ?? gender;

        // Use double.tryParse to robustly handle values stored as either numbers or strings in Firestore
        final fetchedHeight =
            double.tryParse(userDoc.get('height')?.toString() ?? '') ?? height;
        final fetchedWeight =
            double.tryParse(userDoc.get('weight')?.toString() ?? '') ?? weight;
        final fetchedAge =
            double.tryParse(userDoc.get('age')?.toString() ?? '') ?? age;
        final fetchedActivity = userDoc.get('activity') ?? activity;

        final userInfo = UserInfo(
          gender: fetchedGender,
          height: fetchedHeight,
          weight: fetchedWeight,
          age: fetchedAge,
          activity: fetchedActivity,
        );
        emit(UserDetailsLoaded(userInfo));
      } else {
        final userInfo = UserInfo(
          gender: gender,
          height: height,
          weight: weight,
          age: age,
          activity: activity,
        );
        emit(UserDetailsLoaded(userInfo));
      }
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }

  Future<void> saveGoal({
    required UserInfo userInfo,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      emit(const UserDetailsError("User is not authenticated."));
      return;
    }

    emit(UserDetailsSaving(userInfo));

    try {
      final bmiVal = userInfo.calculateBMI();
      final idealweight = userInfo.calculateIdealWeight().toStringAsFixed(1);
      final waterIntake = userInfo.calculateWaterIntake().toStringAsFixed(1);
      final sleepDuration = userInfo.calculateOptimalSleepDuration();
      final HealthStatus = userInfo.calculateAndDetermineBMI();
      final daily = userInfo.dailyCalories;

      await _firestore.collection('users').doc(user.uid).update({
        "dailyCalories": daily.toStringAsFixed(1),
        'BMI': bmiVal.toStringAsFixed(1),
        'idealWeight': idealweight,
        'waterIntake': waterIntake,
        'sleepDuration': sleepDuration,
        'HealthStatus': HealthStatus,
      });

      emit(UserDetailsSaveSuccess(userInfo));
    } catch (e) {
      emit(UserDetailsError(e.toString()));
    }
  }
}
