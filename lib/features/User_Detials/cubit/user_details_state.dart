import 'package:diety/Core/model/UserInfo.dart';

abstract class UserDetailsState {
  const UserDetailsState();
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final UserInfo userInfo;
  const UserDetailsLoaded(this.userInfo);
}

class UserDetailsSaving extends UserDetailsState {
  final UserInfo userInfo;
  const UserDetailsSaving(this.userInfo);
}

class UserDetailsSaveSuccess extends UserDetailsState {
  final UserInfo userInfo;
  const UserDetailsSaveSuccess(this.userInfo);
}

class UserDetailsError extends UserDetailsState {
  final String message;
  const UserDetailsError(this.message);
}
