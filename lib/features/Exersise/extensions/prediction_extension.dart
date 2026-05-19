extension PredictionHealthState on double? {
  String get healthState {
    if (this == null) return 'Loading...';
    if (this == 1.0) return 'Severely Underweight';
    if (this == 2.0) return 'Underweight';
    if (this == 3.0) return 'Mildly Underweight';
    if (this == 4.0) return 'Normal Weight';
    if (this == 5.0) return 'Overweight';
    if (this == 6.0 || this == 7.0) return 'Obesity';
    return 'Unknown';
  }

  String get advanceHealthState {
    if (this == null) return 'Loading...';
    if (this == 1.0) {
      return 'This Program is for People with Severely Underweight. It is designed to help you Gain Weight and build muscle.';
    }
    if (this == 2.0) {
      return 'This Program is for People with Underweight. It is designed to help you Gain Weight and build muscle.';
    }
    if (this == 3.0) {
      return 'This Program is for People with Mildly Underweight. It is designed to help you to Maintain Weight and build muscle.';
    }
    if (this == 4.0) {
      return 'This Program is for People with Normal Weight. It is designed to maintain your current physique and enhance endurance.';
    }
    if (this == 5.0) {
      return 'This Program is for People with Overweight. It is designed to help you Lose Weight and build muscle.';
    }
    if (this == 6.0 || this == 7.0) {
      return 'This Program is for People with Obesity. It is designed to help you Lose Weight and build muscle.';
    }
    return 'Unknown';
  }
}
