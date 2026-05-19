import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diety/features/Asks/cubit/user_info_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit() : super(UserInfoInitial());

  String _gender = 'Male';
  double _height = 170.0;
  double _weight = 70.0;
  double _age = 25.0;
  String _activity = 'Lightly Active';

  String get gender => _gender;
  double get height => _height;
  double get weight => _weight;
  double get age => _age;
  String get activity => _activity;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get uid => _auth.currentUser?.uid;

  void selectGender(String selectedGender) {
    _gender = selectedGender;
    emit(UserInfoGenderSelected(selectedGender));
  }

  void selectHeight(double selectedHeight) {
    _height = selectedHeight;
    emit(UserInfoHeightSelected(selectedHeight));
  }

  void selectWeight(double selectedWeight) {
    _weight = selectedWeight;
    emit(UserInfoWeightSelected(selectedWeight));
  }

  void selectAge(double selectedAge) {
    _age = selectedAge;
    emit(UserInfoAgeSelected(selectedAge));
  }

  void selectActivity(String selectedActivity) {
    _activity = selectedActivity;
    emit(UserInfoActivitySelected(selectedActivity));
  }

  Future<void> saveGender() async {
    final String? currentUid = uid;
    if (currentUid == null) {
      emit(const UserInfoError("User is not authenticated."));
      return;
    }
    emit(UserInfoSaving());
    try {
      await _firestore.collection('users').doc(currentUid).set({
        "email": _auth.currentUser?.email ?? '',
        "gender": _gender,
      }, SetOptions(merge: true));
      emit(UserInfoSaveSuccess());
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  Future<void> saveHeight() async {
    final String? currentUid = uid;
    if (currentUid == null) {
      emit(const UserInfoError("User is not authenticated."));
      return;
    }
    emit(UserInfoSaving());
    try {
      await _firestore.collection('users').doc(currentUid).update({
        "height": _height.toString(),
      });
      emit(UserInfoSaveSuccess());
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  Future<void> saveWeight() async {
    final String? currentUid = uid;
    if (currentUid == null) {
      emit(const UserInfoError("User is not authenticated."));
      return;
    }
    emit(UserInfoSaving());
    try {
      await _firestore.collection('users').doc(currentUid).update({
        "email": _auth.currentUser?.email ?? '',
        "weight": _weight.toString(),
      });
      emit(UserInfoSaveSuccess());
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  Future<void> saveAge() async {
    final String? currentUid = uid;
    if (currentUid == null) {
      emit(const UserInfoError("User is not authenticated."));
      return;
    }
    emit(UserInfoSaving());
    try {
      await _firestore.collection('users').doc(currentUid).update({
        "email": _auth.currentUser?.email ?? '',
        "age": _age.toString(),
      });
      emit(UserInfoSaveSuccess());
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }

  Future<void> saveActivity() async {
    final String? currentUid = uid;
    if (currentUid == null) {
      emit(const UserInfoError("User is not authenticated."));
      return;
    }
    emit(UserInfoSaving());
    try {
      await _firestore.collection('users').doc(currentUid).update({
        "activity": _activity,
      });
      emit(UserInfoSaveSuccess());
    } catch (e) {
      emit(UserInfoError(e.toString()));
    }
  }
}
