enum UserGoalsStatus { initial, loading, loaded, saving, success, error }

class UserGoalsState {
  final UserGoalsStatus status;
  final double dailyCalories;
  final bool isLoseMode;
  final int selectedIndex; // -1 if not selected, otherwise 0..3
  final double caloriesRemaining;
  final String errorMessage;

  const UserGoalsState({
    this.status = UserGoalsStatus.initial,
    this.dailyCalories = 2000.0,
    this.isLoseMode = true,
    this.selectedIndex = -1,
    this.caloriesRemaining = 2000.0,
    this.errorMessage = '',
  });

  UserGoalsState copyWith({
    UserGoalsStatus? status,
    double? dailyCalories,
    bool? isLoseMode,
    int? selectedIndex,
    double? caloriesRemaining,
    String? errorMessage,
  }) {
    return UserGoalsState(
      status: status ?? this.status,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      isLoseMode: isLoseMode ?? this.isLoseMode,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      caloriesRemaining: caloriesRemaining ?? this.caloriesRemaining,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
