import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/User_Goals/cubit/user_goals_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserGoalsCubit extends Cubit<UserGoalsState> {
  UserGoalsCubit() : super(const UserGoalsState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> init(bool isLoseMode) async {
    emit(state.copyWith(status: UserGoalsStatus.loading));
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(
          status: UserGoalsStatus.error,
          errorMessage: "User is not authenticated.",
        ));
        return;
      }

      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        // Fetch daily calories, default to 2000.0 if not found
        final String? dailyCalStr = userDoc.get('dailyCalories')?.toString();
        final double dailyCalories = dailyCalStr != null
            ? (double.tryParse(dailyCalStr) ?? 2000.0)
            : 2000.0;

        emit(state.copyWith(
          status: UserGoalsStatus.loaded,
          dailyCalories: dailyCalories,
          isLoseMode: isLoseMode,
          selectedIndex: -1,
          caloriesRemaining: dailyCalories,
        ));
      } else {
        emit(state.copyWith(
          status: UserGoalsStatus.loaded,
          dailyCalories: 2000.0,
          isLoseMode: isLoseMode,
          selectedIndex: -1,
          caloriesRemaining: 2000.0,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: UserGoalsStatus.error,
        errorMessage: "Failed to load user data: $e",
      ));
    }
  }

  void selectGoalIndex(int index) {
    if (state.status == UserGoalsStatus.loaded) {
      final double diff = 250.0 + index * 250.0;
      final double caloriesRemaining = state.isLoseMode
          ? (state.dailyCalories - diff)
          : (state.dailyCalories + diff);

      emit(state.copyWith(
        selectedIndex: index,
        caloriesRemaining: caloriesRemaining,
      ));
    }
  }

  void toggleGoalMode(bool isLoseMode) {
    if (state.status == UserGoalsStatus.loaded) {
      emit(state.copyWith(
        isLoseMode: isLoseMode,
        selectedIndex: -1,
        caloriesRemaining: state.dailyCalories,
      ));
    }
  }

  Future<void> saveGoal() async {
    if (state.selectedIndex == -1) return;

    emit(state.copyWith(status: UserGoalsStatus.saving));

    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(
          status: UserGoalsStatus.error,
          errorMessage: "User is not authenticated.",
        ));
        return;
      }

      final double weightDiff = 0.25 + state.selectedIndex * 0.25;

      final String actionStr = state.isLoseMode ? "Lose" : "Gain";
      final String goalWeightStr =
          "$actionStr ${weightDiff.toStringAsFixed(2)} Kg per week";

      await _firestore.collection('users').doc(user.uid).update({
        "Calories Remining": state.caloriesRemaining.toStringAsFixed(1),
        "Goal Weight": goalWeightStr,
      });

      emit(state.copyWith(status: UserGoalsStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: UserGoalsStatus.error,
        errorMessage: "Failed to save goal: $e",
      ));
    }
  }
}
