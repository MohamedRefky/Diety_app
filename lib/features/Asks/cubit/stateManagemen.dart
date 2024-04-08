class AgeState{}

class AgeInitial extends AgeState {}

class AgeLoaded extends AgeState {
  final String age;

  AgeLoaded(this.age);
}
