import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> userData;
  final String? profileUrl;

  const ProfileLoaded({
    required this.userData,
    this.profileUrl,
  });

  @override
  List<Object?> get props => [userData, profileUrl];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ProfileActionLoading extends ProfileState {} // For logout/delete operations

class ProfileUnauthenticated extends ProfileState {} // When successfully logged out or deleted
