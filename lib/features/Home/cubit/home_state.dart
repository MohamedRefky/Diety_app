import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String caloriesRemaining;
  final String caloriesConsumed;
  final String selectedDate;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.caloriesRemaining = '2000.0',
    this.caloriesConsumed = '0.0',
    this.selectedDate = '',
    this.errorMessage = '',
  });

  double get remainingDouble => double.tryParse(caloriesRemaining) ?? 0.0;
  double get consumedDouble => double.tryParse(caloriesConsumed) ?? 0.0;

  double get remainingCal {
    final diff = remainingDouble - consumedDouble;
    return diff < 0 ? 0.0 : diff;
  }

  double get percent {
    if (remainingDouble <= 0) return 0.0;
    if (consumedDouble >= remainingDouble) return 1.0;
    return consumedDouble / remainingDouble;
  }

  HomeState copyWith({
    HomeStatus? status,
    String? caloriesRemaining,
    String? caloriesConsumed,
    String? selectedDate,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      caloriesRemaining: caloriesRemaining ?? this.caloriesRemaining,
      caloriesConsumed: caloriesConsumed ?? this.caloriesConsumed,
      selectedDate: selectedDate ?? this.selectedDate,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        caloriesRemaining,
        caloriesConsumed,
        selectedDate,
        errorMessage,
      ];
}
