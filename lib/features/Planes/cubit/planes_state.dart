import 'package:equatable/equatable.dart';
import '../widget/plan_model.dart';

abstract class PlanesState extends Equatable {
  const PlanesState();

  @override
  List<Object?> get props => [];
}

class PlanesInitial extends PlanesState {}

class PlanesLoading extends PlanesState {}

class PlanesLoaded extends PlanesState {
  final List<Plan> plans;

  const PlanesLoaded({required this.plans});

  @override
  List<Object?> get props => [plans];
}

class PlanesError extends PlanesState {
  final String message;

  const PlanesError({required this.message});

  @override
  List<Object?> get props => [message];
}
