import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Search_Food/cubit/search_food_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFoodCubit extends Cubit<SearchFoodState> {
  SearchFoodCubit() : super(const SearchFoodState());

  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> filterValues(String query) async {
    if (query.trim().isEmpty) {
      emit(state.copyWith(suggestions: const []));
      return;
    }

    try {
      final DatabaseEvent event = await _dbRef.once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null && snapshot.value is Map) {
        final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        final List<String> suggestions = [];
        for (var entry in values.entries) {
          final String entryKey = entry.key.toString();
          if (entryKey.toLowerCase().contains(query.toLowerCase())) {
            suggestions.add(entryKey);
          }
        }
        emit(state.copyWith(
          status: SearchFoodStatus.loadedSuggestions,
          suggestions: suggestions,
        ));
      }
    } catch (error) {
      log('Error filtering values: $error');
      emit(state.copyWith(
        status: SearchFoodStatus.error,
        errorMessage: 'Failed to search suggestions.',
      ));
    }
  }

  Future<void> selectAndSearchFood(String food) async {
    emit(state.copyWith(status: SearchFoodStatus.loading));

    try {
      final String? rawValue = await _searchByKeyInDb(food);
      if (rawValue != null) {
        final double baseCal = double.tryParse(rawValue.replaceAll('cal', '').trim()) ?? 0.0;
        final double grams = state.grams;
        final double calculated = double.parse((baseCal * (grams / 100.0)).toStringAsFixed(1));

        emit(state.copyWith(
          status: SearchFoodStatus.foodSelected,
          selectedFoodName: food,
          baseCaloriesPer100g: baseCal,
          calculatedCalories: calculated,
          suggestions: const [],
        ));
      } else {
        emit(state.copyWith(
          status: SearchFoodStatus.error,
          errorMessage: 'Food calorie data not found.',
        ));
      }
    } catch (e) {
      log('Error selecting food: $e');
      emit(state.copyWith(
        status: SearchFoodStatus.error,
        errorMessage: 'An error occurred.',
      ));
    }
  }

  void updateGrams(double grams) {
    final double calculated = double.parse((state.baseCaloriesPer100g * (grams / 100.0)).toStringAsFixed(1));
    emit(state.copyWith(
      grams: grams,
      calculatedCalories: calculated,
    ));
  }

  Future<void> addFoodLogged() async {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      emit(state.copyWith(
        status: SearchFoodStatus.error,
        errorMessage: 'Please login to track your calories.',
      ));
      return;
    }

    emit(state.copyWith(status: SearchFoodStatus.loading));

    try {
      final DocumentReference userRef = _firestore.collection('users').doc(uid);
      final DocumentSnapshot snapshot = await userRef.get();

      double existingCalories = 0.0;
      if (snapshot.exists) {
        final Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        existingCalories = double.tryParse(data?['CaloriesConsumed']?.toString() ?? '0') ?? 0.0;
      }

      final double newCalories = double.parse((existingCalories + state.calculatedCalories).toStringAsFixed(1));

      await userRef.set({
        'CaloriesConsumed': newCalories,
      }, SetOptions(merge: true));

      emit(state.copyWith(
        status: SearchFoodStatus.success,
        successMessage: 'Successfully added ${state.calculatedCalories} kcal for ${state.selectedFoodName}!',
        selectedFoodName: '',
        baseCaloriesPer100g: 0.0,
        calculatedCalories: 0.0,
        suggestions: const [],
      ));
    } catch (e) {
      log('Failed to log food: $e');
      emit(state.copyWith(
        status: SearchFoodStatus.error,
        errorMessage: 'Failed to save calorie log.',
      ));
    }
  }

  void resetSearch() {
    emit(const SearchFoodState());
  }

  Future<String?> _searchByKeyInDb(String key) async {
    try {
      final DatabaseEvent event = await _dbRef.once();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null && snapshot.value is Map) {
        final Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        for (var entry in values.entries) {
          final String entryKey = entry.key.toString().trim().toLowerCase();
          if (entryKey == key.trim().toLowerCase()) {
            return entry.value.toString();
          }
        }
      }
    } catch (error) {
      log('Error searching key: $error');
    }
    return null;
  }
}
