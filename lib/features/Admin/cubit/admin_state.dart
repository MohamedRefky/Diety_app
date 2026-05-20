import 'package:equatable/equatable.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object?> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminUsersLoaded extends AdminState {
  final List<Map<String, dynamic>> users;

  const AdminUsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class AdminActionSuccess extends AdminState {
  final String message;

  const AdminActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AdminError extends AdminState {
  final String message;

  const AdminError(this.message);

  @override
  List<Object?> get props => [message];
}
