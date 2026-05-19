import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileCubit() : super(ProfileInitial());

  Future<void> fetchUserData() async {
    emit(ProfileLoading());
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        emit(ProfileUnauthenticated());
        return;
      }

      final String uid = user.uid;
      
      // Fetch user document from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      
      Map<String, dynamic> userData = {};
      if (userDoc.exists) {
        userData = userDoc.data() as Map<String, dynamic>? ?? {};
      }

      // Fallback: If profileUrl is missing, try SharedPreferences, else Firestore
      String? profileUrl;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedProfileUrl = prefs.getString('profileImageUrl');

      if (storedProfileUrl != null) {
        profileUrl = storedProfileUrl;
      } else if (userData.containsKey('image')) {
        profileUrl = userData['image'] as String?;
      }

      // Add email to userData since it might not be in firestore directly
      userData['email'] = user.email ?? userData['email'] ?? '';

      emit(ProfileLoaded(userData: userData, profileUrl: profileUrl));
    } catch (e) {
      emit(ProfileError(message: 'Failed to load profile data: $e'));
    }
  }

  Future<void> logout() async {
    emit(ProfileActionLoading());
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
      await _auth.signOut();
      emit(ProfileUnauthenticated());
    } catch (e) {
      emit(ProfileError(message: 'Failed to log out: $e'));
    }
  }

  Future<void> deleteAccount() async {
    emit(ProfileActionLoading());
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).delete();
        await user.delete();
        emit(ProfileUnauthenticated());
      }
    } catch (e) {
      emit(ProfileError(message: 'Failed to delete account: $e'));
    }
  }
}
