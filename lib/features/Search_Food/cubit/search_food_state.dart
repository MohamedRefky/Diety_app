import 'package:equatable/equatable.dart';

enum SearchFoodStatus { initial, loading, loadedSuggestions, foodSelected, success, error }

class SearchFoodState extends Equatable {
  final SearchFoodStatus status;
  final List<String> suggestions;
  final String selectedFoodName;
  final double baseCaloriesPer100g;
  final double grams;
  final double calculatedCalories;
  final String errorMessage;
  final String successMessage;

  const SearchFoodState({
    this.status = SearchFoodStatus.initial,
    this.suggestions = const [],
    this.selectedFoodName = '',
    this.baseCaloriesPer100g = 0.0,
    this.grams = 100.0,
    this.calculatedCalories = 0.0,
    this.errorMessage = '',
    this.successMessage = '',
  });

  SearchFoodState copyWith({
    SearchFoodStatus? status,
    List<String>? suggestions,
    String? selectedFoodName,
    double? baseCaloriesPer100g,
    double? grams,
    double? calculatedCalories,
    String? errorMessage,
    String? successMessage,
  }) {
    return SearchFoodState(
      status: status ?? this.status,
      suggestions: suggestions ?? this.suggestions,
      selectedFoodName: selectedFoodName ?? this.selectedFoodName,
      baseCaloriesPer100g: baseCaloriesPer100g ?? this.baseCaloriesPer100g,
      grams: grams ?? this.grams,
      calculatedCalories: calculatedCalories ?? this.calculatedCalories,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        suggestions,
        selectedFoodName,
        baseCaloriesPer100g,
        grams,
        calculatedCalories,
        errorMessage,
        successMessage,
      ];
}
