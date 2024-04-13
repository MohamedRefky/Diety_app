import 'package:diety/features/Asks/widget/UserInfo.dart';
import 'package:flutter/material.dart';

class UserInfoProvider extends ChangeNotifier {
  // Define a private variable to store the user information
  UserInfo _userInfo = UserInfo(
    gender: '',
    age: 0,
    height: 0,
    weight: 0,
    activity: '',
  );

  // Create a getter to access the user information
  UserInfo get userInfo => _userInfo;

  // Method to update the user information
  void updateUserInfo({
    String? gender,
    double? age,
    double? height,
    double? weight,
    String? activity,
  }) {
    _userInfo = UserInfo(
      gender: gender ?? _userInfo.gender,
      age: age ?? _userInfo.age,
      height: height ?? _userInfo.height,
      weight: weight ?? _userInfo.weight,
      activity: activity ?? _userInfo.activity,
    );

    // Notify listeners that the user information has changed
    notifyListeners();
  }
}
