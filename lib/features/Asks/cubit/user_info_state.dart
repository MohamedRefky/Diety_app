abstract class UserInfoState {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {}

class UserInfoSaving extends UserInfoState {}

class UserInfoSaveSuccess extends UserInfoState {}

class UserInfoGenderSelected extends UserInfoState {
  final String gender;
  const UserInfoGenderSelected(this.gender);
}

class UserInfoHeightSelected extends UserInfoState {
  final double height;
  const UserInfoHeightSelected(this.height);
}

class UserInfoWeightSelected extends UserInfoState {
  final double weight;
  const UserInfoWeightSelected(this.weight);
}

class UserInfoAgeSelected extends UserInfoState {
  final double age;
  const UserInfoAgeSelected(this.age);
}

class UserInfoActivitySelected extends UserInfoState {
  final String activity;
  const UserInfoActivitySelected(this.activity);
}

class UserInfoError extends UserInfoState {
  final String message;
  const UserInfoError(this.message);
}
