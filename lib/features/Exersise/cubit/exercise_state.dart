import 'package:equatable/equatable.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final double predictionResult;
  final List<Map<String, dynamic>?> daysData;

  const ExerciseLoaded({
    required this.predictionResult,
    required this.daysData,
  });

  @override
  List<Object?> get props => [predictionResult, daysData];
}

class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError({required this.message});

  @override
  List<Object?> get props => [message];
}
