import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Home/cubit/home_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Timer? _resetTimer;

  Future<void> init() async {
    emit(state.copyWith(
      status: HomeStatus.loading,
      selectedDate: DateFormat.yMd().format(DateTime.now()),
    ));
    await fetchUserData();
    _scheduleMidnightReset();
  }

  Future<void> fetchUserData() async {
    try {
      final User? user = _auth.currentUser;
      if (user == null) {
        emit(state.copyWith(
          status: HomeStatus.error,
          errorMessage: 'User not authenticated',
        ));
        return;
      }

      final DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>?;
        final String remaining =
            data?['Calories Remining']?.toString() ?? '2000.0';
        final String consumed = data?['CaloriesConsumed']?.toString() ?? '0.0';

        emit(state.copyWith(
          status: HomeStatus.loaded,
          caloriesRemaining: remaining,
          caloriesConsumed: consumed,
        ));
      } else {
        emit(state.copyWith(
          status: HomeStatus.loaded,
          caloriesRemaining: '2000.0',
          caloriesConsumed: '0.0',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: 'Failed to fetch user data: $e',
      ));
    }
  }

  void changeSelectedDate(DateTime date) {
    emit(state.copyWith(
      selectedDate: DateFormat.yMd().format(date),
    ));
  }

  void _scheduleMidnightReset() {
    _resetTimer?.cancel();
    final now = DateTime.now();
    // Replicate legacy target reset time (11:43 AM)
    final targetTime = DateTime(now.year, now.month, now.day, 11, 43);
    DateTime nextTrigger = targetTime;
    if (now.isAfter(targetTime)) {
      nextTrigger = targetTime.add(const Duration(days: 1));
    }
    final delay = nextTrigger.difference(now);
    _resetTimer = Timer(delay, () {
      emit(state.copyWith(caloriesConsumed: '0.0'));
      _scheduleMidnightReset();
    });
  }

  @override
  Future<void> close() {
    _resetTimer?.cancel();
    return super.close();
  }
}
